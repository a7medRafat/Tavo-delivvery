import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/models/OrderModel.dart';
import 'package:fooddelivery/modules/orders/view_model/order_details_view_model.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';

class CancelOrder extends StatelessWidget {
  final OrderModel orderData;
  final OrderDetailsViewModel viewModel;

  const CancelOrder(
      {super.key, required this.orderData, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
          decoration: boxDecorationWithRoundedCorners(
              borderRadius: radius(8), backgroundColor: Colors.red),
          child: Text(
            appStore.translate('cancel_order'),
            style: secondaryTextStyle(color: Colors.white, size: 12),
          ),
        ).onTap(() async {
          bool? res = await showConfirmDialog(
              context, appStore.translate('cancel_order_confirmation'),
              negativeText: appStore.translate('no'),
              positiveText: appStore.translate('yes'));
          if (res ?? false) {
            viewModel.cancelOrder(orderData);
          }
        }).paddingOnly(left: 16),
        16.height,
      ],
    ).visible((orderData.orderStatus == ORDER_ASSIGNED) ||
        orderData.orderStatus == ORDER_COOKING);
  }
}
