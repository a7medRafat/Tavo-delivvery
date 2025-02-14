import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fooddelivery/components/AddressListComponent.dart';
import 'package:fooddelivery/core/shared_widgets/toast.dart';
import 'package:fooddelivery/models/UserModel.dart';
import 'package:fooddelivery/modules/my_address/view/screen/MapAddressScreen.dart';
import 'package:fooddelivery/utils/Colors.dart';
import 'package:fooddelivery/utils/functions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

// ignore: must_be_immutable
class MyAddressScreen extends StatefulWidget {
  static String tag = '/MyAddressScreen';
  bool? isOrder = false;

  MyAddressScreen({super.key, this.isOrder});

  @override
  MyAddressScreenState createState() => MyAddressScreenState();
}

class MyAddressScreenState extends State<MyAddressScreen> {
  double? userLatitude;
  double? userLongitude;
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await getCurrentUserLocation();
  }

  Future<void> getCurrentUserLocation() async {
    try {
      final geoPosition = await AppFunctions.getCurrentPosition(context);
      if (geoPosition != null) {
        userLatitude = geoPosition.latitude;
        userLongitude = geoPosition.longitude;
      } else {
        MyToast.show(
          text: 'Unable to fetch current location. Please try again.',
          context: context,
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      MyToast.show(text: 'Error fetching location: $e', context: context);
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(appStore.translate('my_address'),
            color: context.cardColor),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SettingItemWidget(
                padding: const EdgeInsets.only(
                    top: 16, right: 16, left: 16, bottom: 8),
                leading: const Icon(Icons.add, color: colorPrimary),
                title: appStore.translate('add_address'),
                titleTextStyle: primaryTextStyle(color: colorPrimary),
                onTap: () async {
                  const MapAddressScreen().launch(context);
                },
              ),
              Stack(
                children: [
                  StreamBuilder<UserModel>(
                    stream: userDBService.userById(appStore.userId),
                    builder: (_, snap) {
                      if (snap.hasData) {
                        return AddressListComponent(
                            userData: snap.data, isOrder: widget.isOrder);
                      } else {
                        return snapWidgetHelper(snap);
                      }
                    },
                  ),
                  Observer(builder: (_) {
                    return Loader().center().visible(appStore.isLoading);
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
