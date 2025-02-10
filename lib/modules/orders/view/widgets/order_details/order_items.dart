import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/modules/orders/view/widgets/order_details/OrderDetailsComponent.dart';
import 'package:fooddelivery/models/OrderItemData.dart';

class OrderItems extends StatelessWidget {
  final List<OrderItemData> listOfOrder;

  const OrderItems({super.key, required this.listOfOrder});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: listOfOrder.length,
      itemBuilder: (context, index) {
        return OrderDetailsComponent(
          orderDetailsData: listOfOrder[index],
        );
      },
    );
  }
}
