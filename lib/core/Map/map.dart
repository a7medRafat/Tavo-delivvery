import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/core/Map/zoomInOut.dart';
import 'package:fooddelivery/utils/functions.dart';
import 'package:latlong2/latlong.dart';

class MyMap extends StatefulWidget {
  MyMap({
    super.key,
    required this.mapController,
    this.currentLocation,
    this.tappedPoint,
    this.onTap,
  });

  final MapController mapController;
  final LatLng? currentLocation;
  final LatLng? tappedPoint;
  final void Function(TapPosition, LatLng)? onTap;
  bool isLoading = false;

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  double zoom = 15.0;
  LatLng initialLocation = const LatLng(0.0, 0.0);
  bool isLocationLoaded = false;

  @override
  void initState() {
    super.initState();
    setCurrentLocation();
  }

  void setZoom(double zoom) {
    setState(() {
      this.zoom = zoom.clamp(1.0, 22.0);
      widget.mapController.move(widget.mapController.center, this.zoom);
    });
  }

  setCurrentLocation() async {
    setState(() {
      widget.isLoading = true;
    });

    final userLocation = await AppFunctions.getCurrentPosition(context);
    if (userLocation != null) {
      setState(() {
        initialLocation = LatLng(userLocation.latitude, userLocation.longitude);
        isLocationLoaded = true;
      });
      widget.mapController.move(initialLocation, zoom);
    }

    setState(() {
      widget.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      width: double.infinity,
      child: FlutterMap(
        mapController: widget.mapController,
        options: MapOptions(
          minZoom: 15,
          center: isLocationLoaded
              ? widget.currentLocation ?? initialLocation
              : initialLocation,
          zoom: zoom,
          initialCenter: isLocationLoaded
              ? widget.currentLocation ?? initialLocation
              : initialLocation,
          onTap: widget.onTap,
        ),
        children: [
          TileLayer(
            maxNativeZoom: 20,
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(
            markers: [
              if (widget.tappedPoint != null)
                Marker(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  point: widget.tappedPoint!,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.blue,
                    size: 50,
                  ),
                ),
              if (widget.currentLocation != null || isLocationLoaded)
                Marker(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  point: widget.currentLocation ?? initialLocation,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
            ],
          ),
          ZoomInOut(
            getLocation: () => setCurrentLocation(),
            zoomIn: () => setZoom(zoom - 1),
            zoomOut: () => setZoom(zoom + 1),
          )
        ],
      ),
    );
  }
}
