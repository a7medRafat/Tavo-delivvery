import 'package:flutter/material.dart';
import 'package:fooddelivery/components/DeliveryBoyReviewDialog.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/models/OrderModel.dart';
import 'package:fooddelivery/modules/orders/view_model/order_details_view_model.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';

class AddReview extends StatelessWidget {
  final OrderModel orderData;
  final OrderDetailsViewModel viewModel;

  const AddReview(
      {super.key, required this.orderData, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.edit, color: Colors.orangeAccent),
            4.width,
            Text(
              appStore.translate('add_review'),
              style: secondaryTextStyle(color: Colors.orangeAccent, size: 14),
            ),
          ],
        ).onTap(() async {
          bool? res = await showInDialog(
            context,
            barrierDismissible: true,
            // ignore: deprecated_member_use
            child: DeliveryBoyReviewDialog(order: orderData),
            contentPadding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(borderRadius: radius(16)),
          );
          if (res ?? false) {
            viewModel.review(orderData);
          }
        }).paddingLeft(16),
        16.height,
      ],
    ).visible(!viewModel.isReview && orderData.orderStatus == ORDER_COMPLETE);
  }
}
