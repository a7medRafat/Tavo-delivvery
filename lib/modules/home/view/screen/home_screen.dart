import 'package:flutter/material.dart';
import 'package:fooddelivery/core/utils/titles.dart';
import 'package:fooddelivery/modules/home/view/widgets/banners.dart';
import 'package:fooddelivery/modules/home/view/widgets/home_category.dart';
import 'package:fooddelivery/modules/home/view/widgets/home_resturants.dart';
import 'package:fooddelivery/modules/home/view/widgets/home_search.dart';
import 'package:fooddelivery/modules/home/view_model/home_view_model.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // const UserNameImageAddress(),
            const Banners(),
            const HomeSearch(),
            20.height,
            const AppTitle(text: 'categories')
                .visible(viewModel.searchText.isEmpty),
            HomeCategory(viewModel: viewModel),
            10.height,
            const AppTitle(text: 'restaurants')
                .visible(viewModel.searchText.isEmpty),
            HomeRestaurants(viewModel: viewModel)
          ],
        ),
      ),
    );
  }
}
