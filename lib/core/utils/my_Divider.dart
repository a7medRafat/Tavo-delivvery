import 'package:flutter/material.dart';
import '../../config/colors/app_colors.dart';

class MyDivider extends StatelessWidget {

  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: VerticalDivider(
        color:  AppColors.vGray.withOpacity(0.5),
        thickness: 0.5,
      ),
    );
  }
}
