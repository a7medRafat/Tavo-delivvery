import 'package:flutter/material.dart';
import 'package:fooddelivery/config/Strings/app_strings.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/config/style/app_fonts.dart';
import 'package:fooddelivery/core/shared_widgets/app_bar.dart';
import 'package:fooddelivery/core/utils/bottom_nav_bar.dart';
import 'package:fooddelivery/modules/layout/view_model/layout_view_model.dart';
import 'package:provider/provider.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LayoutViewModel>(
      builder: (BuildContext context, LayoutViewModel value, Widget? child) {
        return Scaffold(
          appBar: value.currentNavIndex == 0
              ? MyAppBar(
                  title: Text(
                    AppStrings.appName,
                    style: AppFonts.headline1
                        .copyWith(color: AppColors.primaryColor),
                  ),
                )
              : null,
          key: value.scaffoldKey,
          body: value.screens[value.currentNavIndex],
          bottomNavigationBar: SalomonBottomNav(
            onTap: (index) => value.changeNavButton(index),
            currentIndex: value.currentNavIndex,
          ),
        );
      },
    );
  }
}
