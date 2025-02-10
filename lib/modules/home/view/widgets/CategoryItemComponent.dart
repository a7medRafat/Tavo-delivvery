import 'package:flutter/material.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/models/CategoryModel.dart';
import 'package:fooddelivery/modules/restaurants/view/screens/restaurants_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryItemComponent extends StatelessWidget {
  final CategoryModel? category;

  const CategoryItemComponent({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 115,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.network(category!.image.validate()).image,
                  fit: BoxFit.cover),
              shape: BoxShape.circle,
              color: Colors.transparent,
              boxShadow: defaultBoxShadow(spreadRadius: 0.0, blurRadius: 0.0),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            category!.categoryName.validate(),
            style: primaryTextStyle(
                color: AppColors.darkGray, weight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ).onTap(() {
        hideKeyboard(context);
        RestaurantByCategoryScreen(catName: category!.categoryName.validate())
            .launch(context);
      }),
    );
  }
}
