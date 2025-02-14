import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/core/shared_widgets/toast.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/services/MyCartService.dart';
import 'package:fooddelivery/utils/Common.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:fooddelivery/utils/ModalKeys.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AppFunctions {
  static Future<bool> handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      MyToast.show(
          text: 'Location services are disabled. Please enable them.',
          context: context);

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        MyToast.show(
            text: 'Location permissions are denied.', context: context);

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      MyToast.show(
          text:
              'Location permissions are permanently denied. Please enable them in app settings.',
          context: context);

      return false;
    }

    return true;
  }

  static Future<Position?> getCurrentPosition(BuildContext context) async {
    final hasPermission = await handleLocationPermission(context);
    if (!hasPermission) return null;

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      await getAddressFromLatLng(position.latitude, position.longitude);
      return position;
    } on PlatformException catch (e) {
      debugPrint("PlatformException: ${e.message}");
      MyToast.show(
          text: 'Error fetching location:${e.message}', context: context);

      return null;
    } catch (e) {
      debugPrint("Error fetching location: $e");
      MyToast.show(text: 'Error fetching location: $e', context: context);

      return null;
    }
  }

  static Future<Placemark> getAddressFromLatLng(
      double latitude, double longitude) async {
    final List<Placemark> response =
        await placemarkFromCoordinates(latitude, longitude);
    try {
      Placemark place = response[0];

      userCityNameGlobal = place.locality ?? place.subLocality ?? "Unknown";
      userAddressGlobal =
          "${place.name ?? place.subThoroughfare}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.country}";

      debugPrint("User Address: $userAddressGlobal");

      if (userCityNameGlobal!.validate().isNotEmpty) {
        await appStore.setCityName(userCityNameGlobal);

        if (appStore.isLoggedIn) {
          Map<String, dynamic> data = {
            UserKeys.city: userCityNameGlobal,
            CommonKeys.updatedAt: DateTime.now(),
          };

          await userDBService.updateDocument(data, appStore.userId);
        }
      }

      return place;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception();
    }
  }

  static void launchWhatsApp() async {
    const phoneNumber = '+201122771577';
    const message = 'Hello, I have a question!';
    final url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
