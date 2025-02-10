import 'package:flutter/material.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/config/style/app_fonts.dart';
import 'package:fooddelivery/core/shared_widgets/app_bar.dart';
import 'package:fooddelivery/core/utils/paginate_firestore.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/models/OrderModel.dart';
import 'package:fooddelivery/modules/orders/view/widgets/orders/OrderListComponent.dart';
import 'package:fooddelivery/utils/ModalKeys.dart';

class OrdersScreen extends StatelessWidget {
  static String tag = '/OrderFragment';

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: Text(appStore.translate('orders'),
              style: AppFonts.headline1.copyWith(color: AppColors.darkGray))),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: GenericPaginateFireStore<OrderModel>(
          query: myOrderDBService
              .orderQuery()
              .orderBy(CommonKeys.createdAt, descending: true),
          fromJson: (data) => OrderModel.fromJson(data),
          itemBuilder: (context, order, index) {
            return OrderListComponent(orderData: order);
          },
        ),
      ),
    );
  }
}
