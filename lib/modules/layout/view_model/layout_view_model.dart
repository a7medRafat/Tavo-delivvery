import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/modules/CartFragment.dart';
import 'package:fooddelivery/modules/home/view/screen/home_screen.dart';
import 'package:fooddelivery/modules/orders/view/screens/orders_screen.dart';
import 'package:fooddelivery/modules/ProfileFragment.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';

class LayoutViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int currentNavIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const OrdersScreen(),
    const CartFragment(),
    const ProfileFragment(),
  ];

  void changeNavButton(int index) {
    currentNavIndex = index;
    notifyListeners();
  }

  Future<void> init(context) async {

    int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
    if (themeModeIndex == ThemeModeSystem) {
      appStore.setDarkMode(context.platformBrightness() == Brightness.dark);
    }
    // ignore: deprecated_member_use
    window.onPlatformBrightnessChanged = () {
      if (getIntAsync(THEME_MODE_INDEX) == ThemeModeSystem) {
        appStore.setDarkMode(
            MediaQuery.of(context).platformBrightness == Brightness.light);
      }
    };
  }

}
