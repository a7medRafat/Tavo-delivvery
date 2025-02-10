import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldColor,
    tabBarTheme: TabBarTheme(
      labelStyle: primaryTextStyle(color: AppColors.primaryColor),
      labelColor: AppColors.primaryColor,
    ),
    primaryColor: AppColors.primaryColor,
    fontFamily: GoogleFonts.cairo().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.scaffoldSecondaryDark,
      selectedIconTheme: IconThemeData(
        size: 18.sp,
      ),
      unselectedIconTheme: IconThemeData(
        size: 18.sp,
      ),
      selectedLabelStyle: TextStyle(
        fontSize: 10.sp,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 10.sp,
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.scaffoldSecondaryDark),
    textTheme: const TextTheme(titleLarge: TextStyle(fontSize: 14)),
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.black,
    dividerColor: AppColors.vWhite,
    cardColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(fontSize: 18),
      // brightness: Brightness.light,
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    ),
    dialogTheme: DialogTheme(shape: dialogShape()),
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    // primarySwatch: createMaterialColor(colorPrimary),
    tabBarTheme: TabBarTheme(
      labelStyle: primaryTextStyle(color: AppColors.primaryColor),
      labelColor: AppColors.primaryColor,
    ),
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.scaffoldColorDark,
    fontFamily: GoogleFonts.cairo().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.scaffoldSecondaryDark,
      selectedIconTheme: IconThemeData(
        size: 18.sp,
      ),
      unselectedIconTheme: IconThemeData(
        size: 18.sp,
      ),
      selectedLabelStyle: TextStyle(
        fontSize: 10.sp,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 10.sp,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
        titleLarge: TextStyle(color: textSecondaryColor, fontSize: 14)),
    dialogBackgroundColor: AppColors.scaffoldSecondaryDark,
    unselectedWidgetColor: Colors.white60,
    dividerColor: Colors.white12,
    cardColor: AppColors.scaffoldSecondaryDark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.scaffoldColorDark,
      // brightness: Brightness.dark,
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    ),
    dialogTheme: DialogTheme(shape: dialogShape()),
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
