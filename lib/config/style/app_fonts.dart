import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';

class AppFonts {
  static TextStyle headline1 = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0.sp,
      color: AppColors.whiteColor);

  static TextStyle headline2 = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.0.sp,
      color: AppColors.whiteColor);

  static TextStyle headline3 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14.0.sp,
    color: AppColors.darkGray,
  );

  static TextStyle bodyText1 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 13.0.sp,
  );

  static TextStyle bodyText2 = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 12.0.sp, color: AppColors.darkGray);
  static TextStyle bodyText3 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 11.0.sp,
  );

  static TextStyle bodyText4 = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 13.0.sp,
  );

  static TextStyle bodyText5 = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12.0.sp,
  );
  static TextStyle bodyText6 = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 11.0.sp,
  );

  static TextStyle regular1 = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 13.0.sp,
      color: AppColors.darkGray);

  static TextStyle regular2 = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12.0.sp,
      color: AppColors.darkGray);

  static TextStyle regular3 = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 11.0.sp,
      color: AppColors.darkGray);

  static TextStyle caption = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 11.0.sp,
      color: AppColors.caption);

  static TextStyle lightBold = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 15.0.sp, color: AppColors.vWhite);

  static TextStyle productName = TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 14.0.sp,
      color: AppColors.primaryColor);

  static TextStyle productPrice = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 14.0.sp, color: AppColors.vBlue);

  static TextStyle productOldPrice = TextStyle(
      decoration: TextDecoration.lineThrough,
      fontWeight: FontWeight.w600,
      fontSize: 12.0.sp,
      color: AppColors.caption);

  static TextStyle productDetails = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 13.0.sp,
    color: const Color(0xff5B5B5B),
  );
}
