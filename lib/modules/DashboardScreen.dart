import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/utils/Colors.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';

import 'CartFragment.dart';
import 'home/view/screen/home_screen.dart';
import 'LoginScreen.dart';
import 'orders/view/screens/orders_screen.dart';
import 'ProfileFragment.dart';

class DashboardScreen extends StatefulWidget {
  static String tag = '/DashboardScreen';

  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const OrdersScreen(),
    const CartFragment(),
    ProfileFragment(),
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 400));

    setStatusBarColor(
      context.scaffoldBackgroundColor,
      statusBarIconBrightness: appStore.isDarkMode ? Brightness.light : Brightness.dark,
    );

    int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
    if (themeModeIndex == ThemeModeSystem) {
      appStore.setDarkMode(context.platformBrightness() == Brightness.dark);
    }
    window.onPlatformBrightnessChanged = () {
      if (getIntAsync(THEME_MODE_INDEX) == ThemeModeSystem) {
        appStore.setDarkMode(MediaQuery.of(context).platformBrightness == Brightness.light);
      }
    };
  }

  @override
  void afterFirstLayout(BuildContext context) {
    appStore.setAppLocalization(context);
  }

  @override
  void didUpdateWidget(covariant DashboardScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    appStore.setAppLocalization(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: colorPrimary,
        unselectedItemColor: Colors.grey,
        backgroundColor: appStore.isDarkMode ? scaffoldSecondaryDark : white,
        onTap: (index) {
          if (index == 1 || index == 3) {
            if (!appStore.isLoggedIn) {
              LoginScreen().launch(context);
              return;
            }
          }
          selectedIndex = index;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedLabelStyle: const TextStyle(fontSize: 13),
        unselectedLabelStyle: const TextStyle(fontSize: 13),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.restaurant_menu_outlined), label: appStore.translate('home')),
          BottomNavigationBarItem(icon: const Icon(Icons.shopping_basket_outlined), label: appStore.translate('order')),
          BottomNavigationBarItem(icon: const Icon(Icons.add_shopping_cart_outlined), label: appStore.translate('cart')),
          BottomNavigationBarItem(icon: const Icon(Icons.person_outline), label: appStore.translate('profile')),
        ],
      ),
      body: SafeArea(
        child: screens[selectedIndex],
      ),
    );
  }
}
