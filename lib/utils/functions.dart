import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/utils/ModalKeys.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class AppFunctions {
  static Future<bool> handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, we cannot request permissions.');

      return false;
    }
    if (!serviceEnabled) {
      print('not enabled');
    }
    return true;
  }

  static Future<void> getCurrentPosition(context) async {
    final hasPermission = await handleLocationPermission(context);
    if (!hasPermission) return;

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      await getAddressFromLatLng(position.latitude, position.longitude);
    } on PlatformException catch (e) {
      debugPrint("PlatformException: ${e.message}");
    } catch (e) {
      debugPrint("Error fetching location: $e");
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
}
