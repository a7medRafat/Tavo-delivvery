import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<String> offersImages = [];
  bool isLoading = false;

  Future<void> homeInit(BuildContext context) async {
    setStatusBarColor(
      context.scaffoldBackgroundColor,
      statusBarIconBrightness:
          appStore.isDarkMode ? Brightness.light : Brightness.dark,
    );
    await appSettingService.setAppSettings();
    await getOffersImages();
    try {
      AppFunctions.getCurrentPosition(context);
    } catch (e) {
      debugPrint("Error getting location: $e");
      toast('Error getting location: $e');
    }
  }

  _updateLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  getOffersImages() async {
    _updateLoading(true);
    CollectionReference offersCollection =
        FirebaseFirestore.instance.collection('offers');

    QuerySnapshot querySnapshot = await offersCollection.get();

    if (querySnapshot.docs.isNotEmpty) {
      var doc = querySnapshot.docs.first;
      List<dynamic> offersArray = doc['offers'];
      offersImages = offersArray.map((item) => item.toString()).toList();
    }
    _updateLoading(false);
    notifyListeners();
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
