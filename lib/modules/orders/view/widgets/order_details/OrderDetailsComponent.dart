import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/core/utils/vContainer.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/models/OrderItemData.dart';
import 'package:fooddelivery/utils/Common.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class OrderDetailsComponent extends StatelessWidget {
  static String tag = '/OrderDetailsComponent';
  OrderItemData? orderDetailsData;

  OrderDetailsComponent({super.key, this.orderDetailsData});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppContainer(
          color: context.scaffoldBackgroundColor,
          shadow: defaultBoxShadow(spreadRadius: 0.0, blurRadius: 0.0),
          border: Border.all(color: context.dividerColor),
          borderRadius: BorderRadius.circular(16),
          child: cachedImage(
            orderDetailsData!.image.validate(),
            height: 60.h,
            width: 60.w,
            fit: BoxFit.cover,
          ).cornerRadiusWithClipRRect(12),
        ),
        8.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              orderDetailsData!.itemName.validate(),
              style: boldTextStyle(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Text(
                  '${appStore.translate('price')}: ',
                  style: primaryTextStyle(),
                ),
                2.width,
                Text(getAmount(orderDetailsData!.itemPrice.validate()),
                    style: boldTextStyle()),
              ],
            ),
            // ignore: deprecated_member_use
            createRichText(list: [
              TextSpan(
                  text: '${appStore.translate('restaurant')} - ',
                  style: secondaryTextStyle(weight: FontWeight.w500)),
              TextSpan(
                  text: orderDetailsData!.restaurantName.validate(),
                  style: secondaryTextStyle(weight: FontWeight.w500)),
            ]).visible(orderDetailsData!.restaurantName.validate().isNotEmpty),
          ],
        ).expand(),
        Text('x ${orderDetailsData!.qty.validate().toString()}',
            style: primaryTextStyle()),
      ],
    ).paddingBottom(16);
  }
}
