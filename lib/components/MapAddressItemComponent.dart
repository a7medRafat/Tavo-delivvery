import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/models/AddressModel.dart';
import 'package:fooddelivery/utils/Colors.dart';
import 'package:fooddelivery/utils/ModalKeys.dart';
import 'package:fooddelivery/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../main.dart';

// ignore: must_be_immutable
class MapAddressItemComponent extends StatefulWidget {
  static String tag = '/MapAddressItemComponent';
  TextEditingController? addressController;
  TextEditingController? otherDetailsController;

  double? deliveryUserLat;
  double? deliveryUserLong;
  bool? isUpdate;

  MapAddressItemComponent(
      {super.key,
      this.addressController,
      this.otherDetailsController,
      this.deliveryUserLong,
      this.deliveryUserLat,
      this.isUpdate});

  @override
  MapAddressItemComponentState createState() => MapAddressItemComponentState();
}

class MapAddressItemComponentState extends State<MapAddressItemComponent> {
  var formKey = GlobalKey<FormState>();

  FocusNode addressFocus = FocusNode();
  FocusNode otherDetailsFocus = FocusNode();

  List<AddressModel> listOfAddress = [];
  List<String> favRestaurantList = [];

  String? name;
  String? email;
  String? phoneNumber;
  String? photo;
  String? loginType;
  String? password;
  String? city;

  DateTime? createAt;
  DateTime? updateAt;
  String? userRole;
  String? oneSignalPlayerId;

  bool? isAdmin;
  bool? isTester;
  bool? isDeleted;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  void validate() async {
    hideKeyboard(context);

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      appStore.setLoading(true);

      listOfAddress.add(
        AddressModel(
          address: widget.addressController!.text,
          otherDetails: widget.otherDetailsController!.text,
          userLocation:
              GeoPoint(widget.deliveryUserLat ?? 0.0 , widget.deliveryUserLong ?? 0.0),
        ),
      );

      await userDBService.updateDocument({
        CommonKeys.updatedAt: DateTime.now(),
        UserKeys.listOfAddress: FieldValue.arrayUnion(
            listOfAddress.map((e) => e.toJson()).toList()),
      }, appStore.userId).then((value) {
        toast(appStore.translate('saved'));
        appStore.setLoading(false);
        finish(context);
      }).catchError((e) {
        appStore.setLoading(false);
        log(e);
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      minHeight: context.height() * 0.2,
      maxHeight: context.height() * 0.4,
      color: appStore.isDarkMode ? scaffoldSecondaryDark : Colors.white,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      panel: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  height: 4, width: context.width() * 0.2, color: colorPrimary),
              8.height,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppTextField(
                    controller: widget.addressController!,
                    textFieldType: TextFieldType.ADDRESS,
                    maxLines: 4,
                    autoFocus: false,
                    textStyle: primaryTextStyle(),
                    decoration: labelInputDecoration(
                        labelText: appStore.translate('address')),
                    cursorColor: colorPrimary,
                    focus: addressFocus,
                    nextFocus: otherDetailsFocus,
                  ),
                  16.height,
                  AppTextField(
                    textStyle: primaryTextStyle(),
                    controller: widget.otherDetailsController,
                    textFieldType: TextFieldType.ADDRESS,
                    maxLines: 4,
                    autoFocus: false,
                    focus: otherDetailsFocus,
                    decoration: labelInputDecoration(
                        labelText: appStore.translate('hint_address_other')),
                    cursorColor: colorPrimary,
                  ),
                ],
              ),
              8.height,
              AppButton(
                width: context.width(),
                color: colorPrimary,
                child: Text(appStore.translate('save'),
                    style: boldTextStyle(size: 14, color: Colors.white)),
                onTap: () {
                  validate();
                },
              )
            ],
          ).paddingAll(16),
        ),
      ),
      body: null,
    );
  }
}
