import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddelivery/utils/ModalKeys.dart';

class RestaurantModel {
  final String? id;
  final String? restaurantName;
  final String? photoUrl;
  final String? openTime;
  final String? closeTime;
  final String? restaurantAddress;
  final String? restaurantContact;
  final bool? isVegRestaurant;
  final bool? isNonVegRestaurant;
  final bool? isDealOfTheDay;
  final String? couponCode;
  final String? couponDesc;
  final List<String>? caseSearch;
  final String? restaurantDesc;
  final List<String>? catList;
  final String? restaurantCity;
  final int? deliveryCharge;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RestaurantModel({
    this.id,
    this.restaurantName,
    this.photoUrl,
    this.openTime,
    this.closeTime,
    this.restaurantAddress,
    this.restaurantContact,
    this.isVegRestaurant,
    this.isNonVegRestaurant,
    this.isDealOfTheDay,
    this.couponCode,
    this.couponDesc,
    this.caseSearch,
    this.restaurantDesc,
    this.catList,
    this.restaurantCity,
    this.deliveryCharge,
    this.createdAt,
    this.updatedAt,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json[CommonKeys.id],
      restaurantName: json[RestaurantKeys.restaurantName],
      photoUrl: json[RestaurantKeys.photoUrl],
      openTime: json[RestaurantKeys.openTime],
      closeTime: json[RestaurantKeys.closeTime],
      restaurantAddress: json[RestaurantKeys.restaurantAddress],
      restaurantContact: json[RestaurantKeys.restaurantContact],
      isVegRestaurant: json[RestaurantKeys.isVegRestaurant],
      isNonVegRestaurant: json[RestaurantKeys.isNonVegRestaurant],
      isDealOfTheDay: json[RestaurantKeys.isDealOfTheDay],
      couponCode: json[RestaurantKeys.couponCode],
      couponDesc: json[RestaurantKeys.couponDesc],
      caseSearch: json[RestaurantKeys.caseSearch] != null ? List<String>.from(json[RestaurantKeys.caseSearch]) : null,
      createdAt: json[CommonKeys.createdAt] != null ? (json[CommonKeys.createdAt] as Timestamp).toDate() : null,
      updatedAt: json[CommonKeys.updatedAt] != null ? (json[CommonKeys.updatedAt] as Timestamp).toDate() : null,
      restaurantDesc: json[RestaurantKeys.restaurantDesc],
      catList: json[RestaurantKeys.catList] != null ? List<String>.from(json[RestaurantKeys.catList]) : null,
      restaurantCity: json[RestaurantKeys.restaurantCity],
      deliveryCharge: json[RestaurantKeys.deliveryCharge],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[CommonKeys.id] = id;
    data[RestaurantKeys.restaurantName] = restaurantName;
    data[RestaurantKeys.photoUrl] = photoUrl;
    data[RestaurantKeys.openTime] = openTime;
    data[RestaurantKeys.closeTime] = closeTime;
    data[RestaurantKeys.restaurantAddress] = restaurantAddress;
    data[RestaurantKeys.restaurantContact] = restaurantContact;
    data[RestaurantKeys.isVegRestaurant] = isVegRestaurant;
    data[RestaurantKeys.isNonVegRestaurant] = isNonVegRestaurant;
    data[CommonKeys.createdAt] = createdAt;
    data[CommonKeys.updatedAt] = updatedAt;
    data[RestaurantKeys.isDealOfTheDay] = isDealOfTheDay;
    data[RestaurantKeys.couponCode] = couponCode;
    data[RestaurantKeys.couponDesc] = couponDesc;
    data[RestaurantKeys.caseSearch] = caseSearch;
    data[RestaurantKeys.restaurantDesc] = restaurantDesc;
    data[RestaurantKeys.catList] = catList;
    data[RestaurantKeys.restaurantCity] = restaurantCity;
    data[RestaurantKeys.deliveryCharge] = deliveryCharge;
    return data;
  }
}