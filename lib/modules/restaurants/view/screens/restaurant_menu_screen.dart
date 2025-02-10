import 'package:flutter/material.dart';
import 'package:fooddelivery/components/RestaurantMenuTabWidget.dart';
import 'package:fooddelivery/components/RestaurantMenuTopWidget.dart';
import 'package:fooddelivery/components/ReviewTabComponent.dart';
import 'package:fooddelivery/core/shared_widgets/app_bar.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/models/RestaurantModel.dart';
import 'package:fooddelivery/modules/restaurants/view_model/restaurant_view_model.dart';
import 'package:fooddelivery/utils/Colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RestaurantMenuScreen extends StatelessWidget {
  static String tag = '/RestaurantMenuScreen';

  final RestaurantModel? restaurant;
  final String? restId;

  const RestaurantMenuScreen({super.key, this.restaurant, this.restId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantViewModel(),
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: MyAppBar(
            actions: [
              Consumer<RestaurantViewModel>(
                builder: (context, model, child) {
                  return IconButton(
                    icon: Icon(
                        favRestaurantList.contains(restaurant!.id.validate())
                            ? Icons.favorite
                            : Icons.favorite_border),
                    onPressed: () =>
                        model.favRestaurant(restaurant!.id.validate()),
                  );
                },
              ),
            ],
            backColor:
                appStore.isDarkMode ? scaffoldColorDark : Colors.transparent,
          ),
          body: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 240,
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    bottom: TabBar(
                      labelStyle: boldTextStyle(),
                      unselectedLabelStyle: primaryTextStyle(),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelPadding: const EdgeInsets.all(8),
                      indicatorColor: colorPrimary,
                      unselectedLabelColor: grey,
                      tabs: <Widget>[
                        Text(appStore.translate('menu')),
                        Text(appStore.translate('review')),
                      ],
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: restaurant != null
                          ? RestaurantMenuTopWidget(restaurantData: restaurant)
                          : const SizedBox(),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  RestaurantMenuTabWidget(restaurantData: restaurant),
                  ReviewTabComponent(restaurantData: restaurant),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
