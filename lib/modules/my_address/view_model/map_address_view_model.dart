import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/utils/functions.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapAddressViewModel extends ChangeNotifier {
  LatLng? userLatLong;
  LatLng? lastMapPosition;
  LatLng? tappedPoint;
  Placemark? place;
  String detailedAddress = "";
  String address = "";
  double? deliveryUserLat;
  double? deliveryUserLong;
  bool isLoading = true;
  final formKey = GlobalKey<FormState>();
  final FocusNode addressFocus = FocusNode();
  final FocusNode otherDetailsFocus = FocusNode();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final MapController mapController = MapController();

  _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> init(BuildContext context) async {
    try {
      await getUserLocation(context);
      addressController.text = place?.country ?? '';
      detailsController.text = detailedAddress;
      lastMapPosition = userLatLong;
    } catch (e, stacktrace) {
      print(stacktrace);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getUserLocation(context) async {
    _setLoading(true);

    List<Placemark> placeMarks = [];
    Position? position = await AppFunctions.getCurrentPosition(context);

    if (position != null) {
      userLatLong = LatLng(position.latitude, position.longitude);
      placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      place = placeMarks.isNotEmpty ? placeMarks[0] : null;
    }

    if (place?.locality != null) {
      userCityNameGlobal = place!.locality;
    }
    address = place?.country ?? '';
    detailedAddress =
        "${place?.name}, ${place?.subLocality}, ${place?.locality}, ${place?.administrativeArea} ${place?.postalCode}, ${place?.country}";

    addressController.text = address;
    detailsController.text = detailedAddress;
    deliveryUserLat = position?.latitude;
    deliveryUserLong = position?.longitude;
    _setLoading(false);
    notifyListeners();
  }

  void onMapTap(TapPosition tapPosition, LatLng point) async {
    final placeMark = await AppFunctions.getAddressFromLatLng(
      point.latitude,
      point.longitude,
    );

    tappedPoint = point;
    detailedAddress =
        "${placeMark.name}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.administrativeArea} ${placeMark.postalCode}";
    addressController.text = placeMark.country ?? '';
    detailsController.text = detailedAddress;
    notifyListeners();
  }
}
