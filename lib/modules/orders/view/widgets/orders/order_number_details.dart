import 'package:flutter/material.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/core/utils/vContainer.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/models/OrderModel.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderNumberDetails extends StatelessWidget {
  const OrderNumberDetails({super.key, required this.orderData});

  final OrderModel orderData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appStore.translate('order_number').toUpperCase(),
                style: secondaryTextStyle(size: 12)),
            Text(orderData.orderId.validate(),
                style: primaryTextStyle(size: 14, weight: FontWeight.w500)),
          ],
        ).expand(),
        AppContainer(
            color: context.scaffoldBackgroundColor,
            borderRadius: radius(8),
            border: Border.all(color: Colors.grey.shade500, width: 0.2),
            padding: const EdgeInsets.all(6),
            child: Text(
              appStore.translate('order_detail'),
              style:
                  secondaryTextStyle(color: AppColors.primaryColor, size: 12),
            ))
      ],
    );
  }
}
