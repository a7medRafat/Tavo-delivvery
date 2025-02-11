import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/modules/restaurants/view/widgets/RestaurantItemComponent.dart';
import 'package:fooddelivery/core/utils/paginate_firestore.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/models/RestaurantModel.dart';
import 'package:fooddelivery/modules/home/view_model/home_view_model.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:fooddelivery/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeRestaurants extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeRestaurants({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    if (viewModel.searchText.isNotEmpty){
      return _buildSearchResults(context, viewModel);
    } else if (viewModel.searchText.isEmpty) {
      return _buildPaginatedRestaurantList(context, viewModel);
    } else {
      return _buildNoRestaurantFound();
    }
  }


  Widget _buildSearchResults(BuildContext context, HomeViewModel viewModel) {
    return StreamBuilder<List<RestaurantModel>>(
      stream: restaurantDBService.restaurants(searchText: viewModel.searchText),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString()).center();
        }
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return _buildNoDataWidget(appStore.translate('noRestaurantFound'));
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => RestaurantItemComponent(
                restaurant: snapshot.data![index],
              ),
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data!.length,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
            );
          }
        }
        return Loader().center();
      },
    );
  }

  Widget _buildPaginatedRestaurantList(BuildContext context, HomeViewModel viewModel) {
    return GenericPaginateFireStore<RestaurantModel>(
      query: restaurantDBService.restaurantsQuery(searchText: ''),
      fromJson: (data) => RestaurantModel.fromJson(data),
      itemBuilder: (context, restaurant, index) {
        return RestaurantItemComponent(restaurant: restaurant);
      },
      itemsPerPage: DocLimit,
      isLive: true,
      listeners: [viewModel.refreshChangeListener],
    );
  }
  Widget _buildNoRestaurantFound() {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      child: noDataWidget(errorMessage: appStore.translate('noRestaurantFound')),
    );
  }

  Widget _buildNoDataWidget(String errorMessage) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      child: noDataWidget(errorMessage: errorMessage),
    ).center();
  }
}
