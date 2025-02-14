import 'package:flutter/material.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/core/utils/default_text_field.dart';
import 'package:fooddelivery/core/utils/vContainer.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/modules/home/view_model/home_view_model.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Consumer<HomeViewModel>(
          builder: (BuildContext context, value, Widget? child) {
            return DefaultField(
              controller: value.searchCont,
              prefixIcon: Icon(Icons.search,
                  color: appStore.isDarkMode
                      ? AppColors.whiteColor
                      : AppColors.scaffoldSecondaryDark),
              suffixIcon: value.searchText.isNotEmpty ? Icons.clear : null,
              suffixPressed: () => value.clearSearch(),
              hint: appStore.translate('search_restaurant'),
              isPassword: false,
              textColor: appStore.isDarkMode
                  ? AppColors.whiteColor
                  : AppColors.scaffoldSecondaryDark,
              fillColor: appStore.isDarkMode
                  ? AppColors.scaffoldSecondaryDark
                  : Colors.white,
              textInputType: TextInputType.text,
              borderRadius: BorderRadius.circular(5),
              onChanged: (val) {
                value.setSearchText(val);
              },
              onSubmitted: (s) {
                hideKeyboard(context);
              },
              validation: (val) {},
            ).expand();
          },
        ),
      ],
    ).paddingOnly(left: 16, right: 16, top: 8, bottom: 8);
  }
}
