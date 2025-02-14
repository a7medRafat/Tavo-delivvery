import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MapAddressItemComponent.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/core/Map/map.dart';
import 'package:fooddelivery/modules/my_address/view_model/map_address_view_model.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MapAddressScreen extends StatelessWidget {
  const MapAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MapAddressViewModel()..init(context),
      child: SafeArea(
        child: Scaffold(
          body: Consumer<MapAddressViewModel>(
            builder: (BuildContext context, MapAddressViewModel value,
                Widget? child) {
              return Stack(
                children: [
                  if (value.isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (!value.isLoading)
                    MyMap(
                      mapController: value.mapController,
                      currentLocation: value.userLatLong,
                      tappedPoint: value.tappedPoint,
                      onTap: value.onMapTap,
                    ),
                  if (!value.isLoading)
                    MapAddressItemComponent(
                      addressController: value.addressController,
                      otherDetailsController: value.detailsController,
                      deliveryUserLat: value.deliveryUserLat,
                      deliveryUserLong: value.deliveryUserLong,
                    ),
                  Icon(
                    Icons.arrow_back_outlined,
                    color: AppColors.darkGray,
                  ).onTap(() {
                    finish(context);
                  }).paddingOnly(top: 16, left: 8),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
