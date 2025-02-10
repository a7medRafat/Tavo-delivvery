import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/core/shared_widgets/loading.dart';
import 'package:fooddelivery/core/utils/carusel.dart';
import 'package:fooddelivery/modules/home/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class Banners extends StatelessWidget {
  const Banners({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (BuildContext context, HomeViewModel value, Widget? child) {
        return value.isLoading
            ? const Center(child: Loading())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyCarousel(
                  images: value.offersImages,
                ),
              );
      },
    );
  }
}
