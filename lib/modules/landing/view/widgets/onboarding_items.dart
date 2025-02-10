import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/config/style/app_fonts.dart';

class OnboardingItems extends StatelessWidget {
  final String imageName;
  final String title;

  const OnboardingItems(
      {super.key, required this.imageName, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Image.asset(
              imageName,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppFonts.headline2.copyWith(
              color: AppColors.darkGray,
            ),
          ),
        ],
      ),
    );
  }
}
