import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/core/utils/vContainer.dart';
import 'package:fooddelivery/models/OrderModel.dart';
import 'package:fooddelivery/utils/Common.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderStatus extends StatelessWidget {
  final OrderModel orderData;

  const OrderStatus({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      borderRadius: radius(8),
      color: getOrderStatusColor(orderData.orderStatus).withOpacity(0.05),
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      child: Text(
        getOrderStatusText(orderData.orderStatus.validate()),
        style: boldTextStyle(
          color: getOrderStatusColor(orderData.orderStatus),
          size: 12,
        ),
      ),
    );
  }
}
