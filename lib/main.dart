import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooddelivery/app/myapp.dart';
import 'app/firebase_options.dart';
import 'services/AppSettingService.dart';
import 'services/CategoryDBService.dart';
import 'services/FoodItemDBService.dart';
import 'services/MyCartService.dart';
import 'services/MyOrderDBService.dart';
import 'services/RestaurantDBService.dart';
import 'services/UserDBService.dart';
import 'store/AppStore.dart';
import 'utils/functions.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

MyCartDBService myCartDBService = MyCartDBService();
UserDBService userDBService = UserDBService();
CategoryDBService categoryDBService = CategoryDBService();
MyOrderDBService myOrderDBService = MyOrderDBService();
RestaurantDBService restaurantDBService = RestaurantDBService();
AppSettingService appSettingService = AppSettingService();
FoodItemDBService foodItemDBService = FoodItemDBService();

AppStore appStore = AppStore();

String? restaurantName = '';
String? restaurantId = '';

List<String?> favRestaurantList = [];

String userAddressGlobal = '';
String? userCityNameGlobal = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppFunctions.initMethod();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(const MyApp());
}
