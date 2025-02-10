import 'package:flutter/material.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/config/style/app_fonts.dart';
import 'package:fooddelivery/core/extentions/navigation.dart';
import 'package:fooddelivery/core/shared_widgets/app_bar.dart';
import 'package:fooddelivery/modules/landing/view/widgets/onboarding_items.dart';
import 'package:fooddelivery/modules/landing/view_model/landing_view_model.dart';
import 'package:fooddelivery/modules/layout/view/layout_screen.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LandingViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: MyAppBar(
          backColor: Colors.transparent,
          isCenter: true,
          title: Text(
            "Tavo Delivery",
            style: AppFonts.headline1.copyWith(
              color: AppColors.primaryColor,
              fontSize: 23
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Consumer<LandingViewModel>(
            builder:
                (BuildContext context, LandingViewModel value, Widget? child) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: value.pageController,
                  itemCount: value.boardingImages.length,
                  onPageChanged: (page) => value.updatePage(page),
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  itemBuilder: (BuildContext context, int index) {
                    return OnboardingItems(
                      imageName: value.boardingImages[index],
                      title: value.boardingTitles[index],
                    );
                  },
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.goAndRemoveAll(screen: const AppLayout()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: const Color(0xFFFF6B31),
          splashColor: Colors.transparent,
          icon: const Icon(Icons.chevron_left_rounded, color: Colors.white),
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "تسوق الآن",
              style: AppFonts.headline3.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
