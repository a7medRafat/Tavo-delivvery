import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fooddelivery/core/utils/vContainer.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/models/RestaurantModel.dart';
import 'package:fooddelivery/utils/Common.dart';
import 'package:fooddelivery/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class RestaurantMenuTopWidget extends StatelessWidget {
  static String tag = '/RestaurantMenuTopWidget';
  RestaurantModel? restaurantData;

  RestaurantMenuTopWidget({super.key, this.restaurantData});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        cachedImage(restaurantData!.photoUrl,
            width: context.width(), fit: BoxFit.cover, height: 200),
        AppContainer(
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 10.0, sigmaY: 10.0, tileMode: TileMode.mirror),
            child: Center( // Center the Row
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center, // Align items in the center
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center, // Center column content
                    children: <Widget>[
                      Row(
                        children: [
                          Text(restaurantData!.restaurantName.toString(),
                              style: boldTextStyle(
                                  size: 18, color: Colors.white))
                              .expand(),
                          8.width,
                          Row(
                            children: [
                              vegNonVegIcon(color: Colors.green).visible(
                                  restaurantData!.isVegRestaurant.validate()),
                              4.width,
                              vegNonVegIcon(color: Colors.red).visible(
                                  restaurantData!.isNonVegRestaurant.validate()),
                            ],
                          ),
                        ],
                      ).paddingOnly(left: 16, right: 16, top: 16),
                      4.height,
                      Text(
                        restaurantData!.restaurantAddress.validate(),
                        style: primaryTextStyle(size: 12, color: Colors.white),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ).paddingOnly(left: 16, right: 16),
                      4.height,
                      Row(
                        children: [
                          Text('${appStore.translate('open_hours')}: ',
                              style: secondaryTextStyle(
                                  size: 12, color: Colors.white)),
                          Text(
                            '${restaurantData!.openTime.validate()} - ${restaurantData!.closeTime.validate()}',
                            style:
                            primaryTextStyle(size: 12, color: Colors.white),
                          ),
                        ],
                      ).paddingOnly(left: 16, right: 16),
                      4.height,
                      Text(
                        restaurantData!.restaurantDesc.validate(),
                        style: secondaryTextStyle(size: 12, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ).paddingOnly(left: 16, right: 16),
                    ],
                  ).expand(),
                  cachedImage(restaurantData!.photoUrl.validate(),
                      fit: BoxFit.cover, height: 100, width: 100)
                      .cornerRadiusWithClipRRect(5)
                      .paddingRight(16)
                      .paddingTop(16),
                ],
              ),
            ),
          ),
        ),
      ],
    );

  }
}
