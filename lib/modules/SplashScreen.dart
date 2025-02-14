import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/modules/landing/view/screens/landing_screen.dart';
import 'package:fooddelivery/services/AuthService.dart';
import 'package:fooddelivery/utils/Colors.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await 2.seconds.delay;
    appStore.setAppLocalization(context);

    setStatusBarColor(
      appStore.isDarkMode ? scaffoldColorDark : Colors.transparent,
      statusBarIconBrightness:
          appStore.isDarkMode ? Brightness.light : Brightness.light,
    );

    if (getBoolAsync(IS_FIRST_TIME, defaultValue: true)) {
      const LandingScreen().launch(context, isNewTask: true);
    } else {
      if (appStore.isLoggedIn) {
        appStore.clearCart();
        await myCartDBService.getCartList().then((value) {
          for (var element in value) {
            appStore.addToCart(element);
          }
        });
        await setFavouriteRestaurant();

        const LandingScreen().launch(context, isNewTask: true);
      } else {
        const LoginScreen().launch(context, isNewTask: true);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          appStore.isDarkMode ? scaffoldSecondaryDark : colorPrimary,
      body:
          Text(mAppName, style: primaryTextStyle(size: 36, color: Colors.white))
              .center(),
    );
  }
}
