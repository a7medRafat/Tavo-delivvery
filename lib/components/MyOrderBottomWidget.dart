import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/models/AddressModel.dart';
import 'package:fooddelivery/models/OrderItemData.dart';
import 'package:fooddelivery/models/OrderModel.dart';
import 'package:fooddelivery/modules/MyAddressScreen.dart';
import 'package:fooddelivery/utils/Colors.dart';
import 'package:fooddelivery/utils/Common.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:fooddelivery/utils/functions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import 'OrderSuccessFullyDialog.dart';

// ignore: must_be_immutable
class MyOrderBottomWidget extends StatefulWidget {
  static String tag = '/MyOrderBottomWidget';
  int? totalAmount;
  bool? isOrder;
  double? userLatitude;
  double? userLongitude;
  String? orderAddress;
  final String? voucher;
  Function? onPlaceOrder;

  MyOrderBottomWidget({
    super.key,
    this.totalAmount,
    this.userLatitude,
    this.userLongitude,
    this.orderAddress,
    this.isOrder,
    this.onPlaceOrder,
    this.voucher,
  });

  @override
  MyOrderBottomWidgetState createState() => MyOrderBottomWidgetState();
}

class MyOrderBottomWidgetState extends State<MyOrderBottomWidget> {
  @override
  void initState() {
    super.initState();
  }

  Set<String> processedRestaurantIds = {};

  Future<void> order(String paymentMethod) async {
    processedRestaurantIds = {};
    var id = DateTime.now().millisecondsSinceEpoch;

    List<OrderItemData> items = [];
    for (var element in appStore.mCartList) {
      if (element == null) continue;

      restaurantName = element.restaurantName ?? "Unknown Restaurant";
      restaurantId = element.restaurantId;

      if (restaurantId == null) {
        toast("Invalid restaurant ID");
        return;
      }

      final res = await restaurantDBService.getRestaurantById(restaurantId: restaurantId);
      int voucherCount = (int.tryParse(res.voucherCount ?? '0') ?? 0) - 1;

      items.add(
        OrderItemData(
          image: element.image,
          itemName: element.itemName,
          qty: element.qty,
          id: element.id,
          categoryId: element.categoryId,
          categoryName: element.categoryName,
          itemPrice: element.itemPrice,
          restaurantId: element.restaurantId,
          restaurantName: element.restaurantName,
        ),
      );

      if (res.id != null && !processedRestaurantIds.contains(res.id)) {
        await restaurantDBService.updateRestaurantDate(
          restaurantId: res.id!,
          voucherCount: voucherCount.toString(),
        );
        processedRestaurantIds.add(res.id!);
      }
    }

    if (restaurantId == null || restaurantId!.isEmpty) {
      toast("Error: Restaurant ID is missing.");
      return;
    }

    if (appStore.addressModel?.userLocation == null) {
      toast("Error: User location is missing.");
      return;
    }

    OrderModel orderModel = OrderModel(
      userId: appStore.userId,
      orderStatus: ORDER_NEW,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      totalAmount: widget.totalAmount,
      totalItem: appStore.mCartList.length,
      orderId: id.toString(),
      listOfOrder: items,
      restaurantName: restaurantName,
      restaurantId: restaurantId,
      userAddress: appStore.addressModel?.address ?? "No address provided",
      paymentMethod: paymentMethod,
      deliveryCharge: getIntAsync(DELIVERY_CHARGES),
      restaurantCity: getStringAsync(USER_CITY_NAME),
      paymentStatus: PAYMENT_STATUS_PENDING,
      userLocation: GeoPoint(
        appStore.addressModel!.userLocation!.latitude,
        appStore.addressModel!.userLocation!.longitude,
      ),
    );

    try {
      await myOrderDBService.addDocument(orderModel.toJson());

      // Remove items from cart safely
      await Future.forEach(appStore.mCartList, (dynamic element) async {
        if (element?.id != null) {
          await myCartDBService.removeDocument(element.id);
        }
      });

      appStore.clearCart();
      widget.totalAmount = 0;
      widget.onPlaceOrder?.call();

      showInDialog(
        context,
        child: const OrderSuccessFullyDialog(),
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: radius(12)),
      );
    } catch (e) {
      print(e.toString());
      log(e);
      toast("Error placing order: ${e.toString()}");
    }
  }

  void address() async {
    toast(appStore.translate('hint_select_address'));
    await Future.delayed(const Duration(milliseconds: 100));

    AddressModel? data =
        await MyAddressScreen(isOrder: widget.isOrder).launch(context);
    if (data != null) {
      appStore.setAddressModel(data);
      setState(() {});
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: appStore.isDarkMode ? context.cardColor : colorPrimary,
        borderRadius: radiusOnly(topRight: 16, topLeft: 16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(appStore.translate('total_item'),
                  style: secondaryTextStyle(color: Colors.white, size: 14)),
              Observer(
                builder: (_) => Text(
                  appStore.mCartList.length.toString(),
                  style: boldTextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(appStore.translate('delivery_charges'),
                  style: secondaryTextStyle(color: Colors.white)),
              Text(getAmount(getIntAsync(DELIVERY_CHARGES)),
                  style: boldTextStyle(color: Colors.white)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Voucher', style: primaryTextStyle(color: Colors.white)),
              Text(widget.voucher!,
                  style: boldTextStyle(color: Colors.white, size: 20)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(appStore.translate('total').toUpperCase(),
                  style: primaryTextStyle(color: Colors.white)),
              Text(getAmount(widget.totalAmount.validate()),
                  style: boldTextStyle(color: Colors.white, size: 20)),
            ],
          ),
          30.height,
          appStore.addressModel == null
              ? AppButton(
                  width: double.infinity,
                  shapeBorder: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  color: appStore.isDarkMode ? colorPrimary : Colors.white,
                  onTap: () async {
                    address();
                  },
                  child: Text(
                    'select address',
                    style: boldTextStyle(
                        color: appStore.isDarkMode ? white : colorPrimary),
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        shapeBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        color:
                            appStore.isDarkMode ? colorPrimary : Colors.white,
                        onTap: () async {
                          showConfirmDialog(
                            context,
                            appStore.translate('place_order_confirmation'),
                            negativeText: appStore.translate('no'),
                            positiveText: appStore.translate('yes'),
                          ).then((value) async {
                            if (value ?? false) {
                              await order(CASH_ON_DELIVERY);
                            }
                          }).catchError((e) {
                            toast(e.toString());
                          });
                        },
                        child: Text(
                          appStore.translate('cashOnDelivery'),
                          style: boldTextStyle(
                              color:
                                  appStore.isDarkMode ? white : colorPrimary),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: AppButton(
                        shapeBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        color:
                            appStore.isDarkMode ? colorPrimary : Colors.white,
                        onTap: () async {
                          showConfirmDialog(
                            context,
                            appStore.translate('place_order_confirmation'),
                            negativeText: appStore.translate('no'),
                            positiveText: appStore.translate('yes'),
                          ).then((value) async {
                            if (value ?? false) {
                              await order(VODAFON_CASH);
                              AppFunctions.launchWhatsApp();
                            }
                          }).catchError((e) {
                            toast(e.toString());
                          });
                        },
                        child: Text(
                          appStore.translate('vodafoneCash'),
                          style: boldTextStyle(
                            color: appStore.isDarkMode ? white : colorPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
