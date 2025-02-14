import 'package:flutter/material.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/config/style/app_fonts.dart';
import 'package:fooddelivery/main.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.backColor,
    this.isCenter,
  });

  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backColor;
  final bool? isCenter;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      centerTitle: isCenter,
      titleSpacing: 4,
      elevation: 0,
      backgroundColor: backColor,
      titleTextStyle: AppFonts.headline1.copyWith(
        color: appStore.isDarkMode ? AppColors.whiteColor : AppColors.darkGray,
      ),
      actions: actions,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: title,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
