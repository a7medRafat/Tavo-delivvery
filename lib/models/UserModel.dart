import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddelivery/models/AddressModel.dart';
import 'package:fooddelivery/utils/ModalKeys.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  String? number;
  String? password;
  String? loginType;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isAdmin;
  bool? isTester;
  List<AddressModel>? listOfAddress;
  String? role;
  List<String>? favRestaurant;
  String? city;
  bool? isDeleted;
  String? oneSignalPlayerId;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.number,
    this.password,
    this.loginType,
    this.createdAt,
    this.updatedAt,
    this.isAdmin,
    this.isTester,
    this.listOfAddress,
    this.role,
    this.favRestaurant,
    this.city,
    this.isDeleted,
    this.oneSignalPlayerId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json[UserKeys.uid],
      name: json[UserKeys.name],
      email: json[UserKeys.email],
      photoUrl: json[UserKeys.photoUrl],
      isAdmin: json[UserKeys.isAdmin],
      isTester: json[UserKeys.isTester],
      number: json[UserKeys.number],
      password: json[UserKeys.password],
      loginType: json[UserKeys.loginType],
      createdAt: json[CommonKeys.createdAt] != null ? (json[CommonKeys.createdAt] as Timestamp).toDate() : null,
      updatedAt: json[CommonKeys.updatedAt] != null ? (json[CommonKeys.updatedAt] as Timestamp).toDate() : null,
      listOfAddress: json[UserKeys.listOfAddress] != null
          ? (json[UserKeys.listOfAddress] as List).map<AddressModel>((e) => AddressModel.fromJson(e)).toList()
          : null,
      role: json[UserKeys.role],
      favRestaurant: json[UserKeys.favRestaurant] != null ? List<String>.from(json[UserKeys.favRestaurant]) : [],
      city: json[UserKeys.city],
      isDeleted: json[CommonKeys.isDeleted],
      oneSignalPlayerId: json[UserKeys.oneSignalPlayerId],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[UserKeys.uid] = uid;
    data[UserKeys.name] = name;
    data[UserKeys.email] = email;
    data[UserKeys.photoUrl] = photoUrl;
    data[UserKeys.loginType] = loginType;
    data[CommonKeys.createdAt] = createdAt;
    data[CommonKeys.updatedAt] = updatedAt;
    data[UserKeys.isAdmin] = isAdmin;
    data[UserKeys.isTester] = isTester;
    data[UserKeys.number] = number;
    data[UserKeys.password] = password;
    data[UserKeys.listOfAddress] = listOfAddress?.map((e) => e.toJson()).toList();
    data[UserKeys.role] = role;
    data[UserKeys.favRestaurant] = favRestaurant;
    data[UserKeys.city] = city;
    data[CommonKeys.isDeleted] = isDeleted;
    data[UserKeys.oneSignalPlayerId] = oneSignalPlayerId;
    return data;
  }}
