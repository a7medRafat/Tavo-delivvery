import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fooddelivery/components/MyOrderBottomWidget.dart';
import 'package:fooddelivery/components/MyOrderListItemComponent.dart';
import 'package:fooddelivery/components/MyOrderUserInfoComponent.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/services/UserDBService.dart';
import 'package:fooddelivery/utils/Colors.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class MyOrderScreen extends StatefulWidget {
  static String tag = '/MyOrderScreen';

  String? orderAddress;

  MyOrderScreen({super.key, this.orderAddress});

  @override
  MyOrderScreenState createState() => MyOrderScreenState();
}

class MyOrderScreenState extends State<MyOrderScreen> {
  int totalAmount = 0;
  UserDBService? userDBService;

  double? userLatitude;
  double? userLongitude;
  bool? isOrder;
  double voucher = 0.0;
  Set<String> processedRestaurantIds = {};
  String address = "";

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    for (var e in appStore.mCartList) {
      if (!processedRestaurantIds.contains(e!.restaurantId)) {
        final res = await restaurantDBService.getRestaurantById(
            restaurantId: e.restaurantId);

        if (res.voucher != null) {
          voucher += res.voucher!.toDouble();
          processedRestaurantIds.add(e.restaurantId!);
        }
      }
    }

    calculateTotal();
    getCurrentUserLocation();
    setStatusBarColor(
      appStore.isDarkMode ? scaffoldColorDark : colorPrimary,
      statusBarIconBrightness:
          appStore.isDarkMode ? Brightness.light : Brightness.dark,
    );
  }

  getCurrentUserLocation() async {
    final geoPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      userLatitude = geoPosition.longitude;
      userLongitude = geoPosition.latitude;
    });
  }

  void calculateTotal() {
    totalAmount = appStore.mCartList.sumBy(((e) => e!.itemPrice! * e.qty!)) +
        getIntAsync(DELIVERY_CHARGES) -
        voucher.toInt();
    setState(() {});
  }

  @override
  void dispose() {
    setStatusBarColor(
      appStore.isDarkMode ? scaffoldColorDark : colorPrimary,
      statusBarIconBrightness:
          appStore.isDarkMode ? Brightness.light : Brightness.dark,
    );
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(appStore.translate('checkout'),
            color: appStore.isDarkMode ? scaffoldColorDark : colorPrimary,
            textColor: white,
            showBack: true),
        body: Column(
          children: [
            MyOrderUserInfoComponent(isOrder: true),
            16.height,
            Observer(
              builder: (_) => ListView.builder(
                itemCount: appStore.mCartList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return MyOrderListItemComponent(
                    myOrderData: appStore.mCartList[index],
                  );
                },
              ).expand(),
            ),
          ],
        ),
        bottomNavigationBar: MyOrderBottomWidget(
          totalAmount: totalAmount,
          userLatitude: userLatitude,
          userLongitude: userLongitude,
          orderAddress: address,
          voucher: voucher.toString(),
          isOrder: true,
          onPlaceOrder: () {
            setState(() {});
          },
        ),
      ),
    );
  }
}
