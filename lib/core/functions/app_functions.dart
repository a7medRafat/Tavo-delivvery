import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/core/shared_widgets/toast.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/services/MyCartService.dart';
import 'package:fooddelivery/utils/Common.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../utils/placeholder.dart';

class AppFunctions {
  static Future<bool> handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      MyToast.show(
          text: 'Location services are disabled. Please enable the services',
          context: context);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        MyToast.show(text: 'Location permissions are denied', context: context);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      MyToast.show(
          text:
              'Location permissions are permanently denied, we cannot request permissions.',
          context: context);

      return false;
    }
    if (!serviceEnabled) {
      debugPrint('not enabled');
    }
    return true;
  }

  static Future<void> getCurrentPosition(context) async {
    final hasPermission = await handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      await getAddressFromLatLng(position.latitude, position.longitude);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  static Future<Placemark> getAddressFromLatLng(
      double latitude, double longitude) async {
    final List<Placemark> response =
        await placemarkFromCoordinates(latitude, longitude);
    try {
      Placemark place = response[0];

      return place;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception();
    }
  }

  Widget imageHandler({required String img, double? width, double? height}) {
    try {
      return Image.network(
        width: width,
        height: height,
        img,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return const ImgPlaceHolder();
          }
          return CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          );
        },
      );
    } catch (e) {
      debugPrint('Error loading image: $e');
      return const ImgPlaceHolder(); // Display a placeholder image or error message
    }
  }

  static Future<void> initMethod() async {
    await initialize(aLocaleLanguageList: [
      LanguageDataModel(
          id: 1,
          name: 'Arabic',
          languageCode: 'ar',
          flag: 'assets/flag/ic_ar.png'),
      LanguageDataModel(
          id: 2,
          name: 'English',
          languageCode: 'en',
          flag: 'assets/flag/ic_us.png'),
    ]);
    defaultLoaderAccentColorGlobal = AppColors.primaryColor;

    selectedLanguageDataModel =
        getSelectedLanguageModel(defaultLanguage: defaultLanguage);
    if (selectedLanguageDataModel != null) {
      appStore.setLanguage(selectedLanguageDataModel!.languageCode.validate());
    } else {
      selectedLanguageDataModel = localeLanguageList.first;
      appStore.setLanguage(selectedLanguageDataModel!.languageCode.validate());
    }

    if (isMobile) {
      await Firebase.initializeApp();

      // await OneSignal.shared.setAppId(mOneSignalAppId);

      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
      OneSignal.Debug.setAlertLevel(OSLogLevel.none);
      OneSignal.consentRequired(false);

      OneSignal.initialize(mOneSignalAppId);
      OneSignal.User.pushSubscription.optIn();
      OneSignal.Notifications.permission;

      // OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
      //   event.complete(event.notification);
      // });
      OneSignal.Notifications.addForegroundWillDisplayListener((notification) {
        print(notification);
        // event.complete(event.notification);
      });
      saveOneSignalPlayerId();
    }

    appStore.setDarkMode(appStore.isDarkMode);
    appStore
        .setNotification(getBoolAsync(IS_NOTIFICATION_ON, defaultValue: true));

    appStore.setLoggedIn(getBoolAsync(IS_LOGGED_IN));
    if (appStore.isLoggedIn) {
      appStore.setUserId(getStringAsync(USER_ID));
      appStore.setAdmin(getBoolAsync(ADMIN));
      appStore.setFullName(getStringAsync(USER_DISPLAY_NAME));
      appStore.setUserEmail(getStringAsync(USER_EMAIL));
      appStore.setUserProfile(getStringAsync(USER_PHOTO_URL));

      myCartDBService = MyCartDBService();
    }

    int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
    if (themeModeIndex == ThemeModeLight) {
      appStore.setDarkMode(false);
    } else if (themeModeIndex == ThemeModeDark) {
      appStore.setDarkMode(true);
    }
  }
}
