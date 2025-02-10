import 'package:flutter/material.dart';
import 'package:fooddelivery/core/shared_widgets/app_bar.dart';
import 'package:fooddelivery/core/utils/vContainer.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/models/OrderItemData.dart';
import 'package:fooddelivery/models/OrderModel.dart';
import 'package:fooddelivery/modules/orders/view/widgets/order_details/add_review.dart';
import 'package:fooddelivery/modules/orders/view/widgets/order_details/cancel_order.dart';
import 'package:fooddelivery/modules/orders/view/widgets/order_details/order_details.dart';
import 'package:fooddelivery/modules/orders/view/widgets/order_details/order_items.dart';
import 'package:fooddelivery/modules/orders/view/widgets/order_details/track_order.dart';
import 'package:fooddelivery/modules/orders/view_model/order_details_view_model.dart';
import 'package:fooddelivery/utils/Colors.dart';
import 'package:fooddelivery/utils/Common.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OrderDetailsScreen extends StatelessWidget {
  static String tag = '/OrderDetailsScreen';
  List<OrderItemData>? listOfOrder;
  OrderModel? orderData;

  OrderDetailsScreen({super.key, this.listOfOrder, this.orderData});

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<OrderDetailsViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init(orderData!);
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const MyAppBar(
        backColor: Colors.transparent,
        title: Text(''),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/order.jpg',
              height: SizeConfig.screenHeight,
              width: double.infinity,
            ),
            8.height,
            OrderDetails(orderData: orderData!),
            16.height,
            AddReview(orderData: orderData!, viewModel: viewModel),
            CancelOrder(orderData: orderData!, viewModel: viewModel),
            TrackOrder(orderData: orderData!),
            8.height,
            const Divider(thickness: 1),
            16.height,
            Text(appStore.translate('order_items'), style: boldTextStyle())
                .paddingLeft(16),
            OrderItems(listOfOrder: listOfOrder!),
          ],
        ),
      ),
      bottomNavigationBar: AppContainer(
        padding: const EdgeInsets.only(bottom: 16, top: 8),
        color: appStore.isDarkMode ? scaffoldColorDark : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(appStore.translate('total'),
                style: primaryTextStyle(size: 18)),
            Text(getAmount(orderData!.totalAmount.validate()),
                style: boldTextStyle(size: 18)),
          ],
        ).paddingOnly(left: 16, right: 16),
      ),
    );
  }
}
