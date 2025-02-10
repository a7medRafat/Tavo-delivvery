import 'package:flutter/material.dart';
import 'package:fooddelivery/core/extentions/navigation.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/models/OrderModel.dart';
import 'package:fooddelivery/modules/OrderTrackingScreen.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';

class TrackOrder extends StatelessWidget {
  final OrderModel orderData;

  const TrackOrder({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      padding: const EdgeInsets.all(8),
      color: Colors.green,
      child: Text(appStore.translate('track_order'),
          style: boldTextStyle(color: Colors.white, size: 14)),
      onTap: () => context.go(
        screen: OrderTrackingScreen(orderData: orderData),
      ),
    ).paddingLeft(16).visible(orderData.orderStatus == ORDER_DELIVERING);
  }
}
