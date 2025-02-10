import 'package:flutter/material.dart';
import 'package:fooddelivery/core/extentions/navigation.dart';
import 'package:fooddelivery/core/utils/vContainer.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/models/OrderModel.dart';
import 'package:fooddelivery/modules/orders/view/screens/order_details_screen.dart';
import 'package:fooddelivery/modules/orders/view/widgets/orders/order_number_details.dart';
import 'package:fooddelivery/modules/orders/view/widgets/orders/order_status.dart';
import 'package:fooddelivery/utils/Common.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class OrderListComponent extends StatelessWidget {
  static String tag = '/OrderListComponent';
  OrderModel? orderData;

  OrderListComponent({super.key, this.orderData});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      color: context.cardColor,
      border: Border.all(
        color: getOrderStatusColor(orderData!.orderStatus).withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderNumberDetails(orderData: orderData!),
          8.height,
          Text(
              '${orderData!.totalItem.validate()} ${appStore.translate('items')}',
              style: boldTextStyle(size: 14)),
          Text(
            '${appStore.translate('order_on')} ${DateFormat('EEE d, MMM yyyy HH:mm:ss').format(orderData!.createdAt!)}',
            style: secondaryTextStyle(size: 12),
          ),
          8.height,
          OrderStatus(orderData: orderData!),
        ],
      ).onTap(() {
        context.go(
          screen: OrderDetailsScreen(
            listOfOrder: orderData!.listOfOrder,
            orderData: orderData,
          ),
        );
      }, borderRadius: radius()),
    );
  }
}
