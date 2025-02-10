import 'package:flutter/material.dart';

import '../../config/colors/app_colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: AppColors.primaryColor,
      strokeWidth: 3,
    );
  }
}
