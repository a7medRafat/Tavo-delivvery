import 'package:flutter/material.dart';
import 'package:fooddelivery/modules/restaurants/view/widgets/RestaurantItemComponent.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/config/style/app_fonts.dart';
import 'package:fooddelivery/core/shared_widgets/app_bar.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/models/RestaurantModel.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:fooddelivery/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class RestaurantByCategoryScreen extends StatelessWidget {
  static String tag = '/RestaurantByCategoryScreen';
  final String? catName;

  const RestaurantByCategoryScreen({super.key, this.catName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          title: Text(
            catName.validate(),
            style: AppFonts.headline1.copyWith(color: AppColors.darkGray),
          ),
          backColor: context.cardColor,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: StreamBuilder<List<RestaurantModel>>(
              stream: restaurantDBService.restaurantByCategory(catName,
                  cityName: getStringAsync(USER_CITY_NAME)),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString()).center();
                }
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: noDataWidget(
                          errorMessage: appStore.translate('noRestaurantFound'),
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return RestaurantItemComponent(
                          restaurant: snapshot.data![index],
                        );
                      },
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data!.length,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                    );
                  }
                }
                return Loader().center();
              }),
        ),
      ),
    );
  }
}
