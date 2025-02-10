import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/config/style/app_fonts.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/models/OrderModel.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderDetails extends StatelessWidget {
  final OrderModel orderData;

  const OrderDetails({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '#${orderData.orderId}',
            style: AppFonts.headline2.copyWith(color: AppColors.darkGray),
          ),
          8.height,
          Text(
            '${appStore.translate('delivery_by')} ${DateFormat('EEE d, MMM yyyy HH:mm:ss').format(orderData.createdAt!)}',
            style: boldTextStyle(size: 12),
          ),
          5.height,
          Text(
            '${appStore.translate('deliver_to')} ${orderData.userAddress.validate()}',
            style: boldTextStyle(size: 12),
          ),
        ],
      ),
    );
  }
}
