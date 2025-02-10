import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/core/utils/vContainer.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/models/RestaurantModel.dart';
import 'package:fooddelivery/modules/restaurants/view/screens/restaurant_menu_screen.dart';
import 'package:fooddelivery/utils/Colors.dart';
import 'package:fooddelivery/utils/Common.dart';
import 'package:fooddelivery/utils/Images.dart';
import 'package:nb_utils/nb_utils.dart';

class RestaurantItemComponent extends StatelessWidget {
  final RestaurantModel? restaurant;
  final String? tag;

  const RestaurantItemComponent({super.key, this.restaurant, this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: context.width(),
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: context.scaffoldBackgroundColor,
        boxShadow: defaultBoxShadow(spreadRadius: 0.0, blurRadius: 0.0),
        border: Border.all(color: context.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              cachedImage(
                restaurant!.photoUrl.validate(),
                height: 180.h,
                width: context.width(),
                fit: BoxFit.cover,
              ).cornerRadiusWithClipRRectOnly(topLeft: 8, topRight: 8),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(restaurant!.restaurantName.validate(),
                  style: boldTextStyle(size: 20)),
              Text(
                restaurant!.restaurantAddress.validate(),
                style: secondaryTextStyle(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ).paddingAll(8),
          AppContainer(
            width: context.width(),
            padding: const EdgeInsets.all(12),
            color: Colors.blue.withOpacity(0.2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(ic_shield, height: 20, color: Colors.blue),
                10.width,
                Text(
                  appStore.translate('safety_measured_followed_here'),
                  style: primaryTextStyle(color: grey),
                ),
              ],
            ),
          ).cornerRadiusWithClipRRectOnly(bottomLeft: 8, bottomRight: 8),
        ],
      ),
    ).onTap(() {
      hideKeyboard(context);
      RestaurantMenuScreen(restaurant: restaurant).launch(context);
    },
        highlightColor:
            appStore.isDarkMode ? scaffoldColorDark : context.cardColor);
  }
}
