import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/services/RestaurantReviewDBService.dart';
import 'package:fooddelivery/utils/Colors.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:fooddelivery/utils/ModalKeys.dart';
import 'package:nb_utils/nb_utils.dart';

class RestaurantViewModel extends ChangeNotifier {
  RestaurantReviewsDBService? restaurantReviewsDBService;
  TabController? tabController;

  restaurantMenuInit(TickerProvider provider) {
    tabController = TabController(length: 2, vsync: provider);
    setStatusBarColor(appStore.isDarkMode ? scaffoldColorDark : colorPrimary,
        statusBarIconBrightness: Brightness.light);
  }

  init() async {
    setStatusBarColor(
      appStore.isDarkMode ? scaffoldColorDark : white,
      statusBarIconBrightness:
          appStore.isDarkMode ? Brightness.light : Brightness.dark,
    );
  }

  Future<void> addToFavRestaurant(String restaurantId) async {
    favRestaurantList.add(restaurantId);

    await userDBService.updateDocument({
      UserKeys.favRestaurant: favRestaurantList,
      CommonKeys.updatedAt: DateTime.now(),
    }, appStore.userId).then((value) {
      //
    }).catchError((e) {
      print(e);
    });
    notifyListeners();
  }

  Future<void> removeToRestaurant(String restaurantId) async {
    favRestaurantList.remove(restaurantId);

    await userDBService.updateDocument({
      UserKeys.favRestaurant: favRestaurantList,
      CommonKeys.updatedAt: DateTime.now(),
    }, appStore.userId).then((value) {
      //
    }).catchError((e) {
      favRestaurantList.add(restaurantId);
    });
    notifyListeners();
  }

  Future<void> favRestaurant(String restaurantId) async {
    if (appStore.isLoggedIn) {
      if (favRestaurantList.contains(restaurantId)) {
        await removeToRestaurant(restaurantId);
      } else {
        await addToFavRestaurant(restaurantId);
      }
      await setValue(FAVORITE_RESTAURANT, jsonEncode(favRestaurantList));

      notifyListeners();
    }
  }

  @override
  void dispose() {
    setStatusBarColor(
      appStore.isDarkMode ? scaffoldColorDark : white,
      statusBarIconBrightness:
          appStore.isDarkMode ? Brightness.light : Brightness.dark,
    );
    super.dispose();
  }
}
