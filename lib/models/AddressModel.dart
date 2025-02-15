import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddelivery/utils/ModalKeys.dart';

class AddressModel {
  String? address;
  String? otherDetails;
  GeoPoint? userLocation;

  AddressModel({this.address, this.otherDetails, this.userLocation});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      address: json[AddressKeys.address],
      otherDetails: json[AddressKeys.details],
      userLocation: json[AddressKeys.userLocation],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[AddressKeys.address] = address;
    data[AddressKeys.details] = otherDetails;
    data[AddressKeys.userLocation] = userLocation;

    return data;
  }
}
