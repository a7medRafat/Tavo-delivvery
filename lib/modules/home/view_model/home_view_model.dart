import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/core/functions/app_functions.dart';
import 'package:fooddelivery/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';

class HomeViewModel extends ChangeNotifier {
  TextEditingController searchCont = TextEditingController();
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  String searchText = '';
  LatLng? userLatLng;
  int retry = 0;

  Future<void> homeInit(BuildContext context) async {
    await appSettingService.setAppSettings();
    setStatusBarColor(
      context.scaffoldBackgroundColor,
      statusBarIconBrightness:
          appStore.isDarkMode ? Brightness.light : Brightness.dark,
    );

    try {
      AppFunctions.getCurrentPosition(context);
    } catch (e) {
      debugPrint("Error getting location: $e");
      toast('Error getting location: $e');
    }
  }

  void setSearchText(String text) {
    searchText = text;
    notifyListeners();
  }

  void clearSearch() {
    searchText = '';
    searchCont.clear();
    notifyListeners();
  }
}
