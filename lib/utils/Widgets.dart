import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/config/style/app_fonts.dart';
import 'package:fooddelivery/core/utils/vContainer.dart';
import 'package:fooddelivery/utils/Colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

Widget vegNonVegIcon({required Color color}) {
  return Container(
    decoration: boxDecorationWithRoundedCorners(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(4)),
    child: Icon(Octicons.dot_fill, size: 20, color: color).center(),
  );
}

InputDecoration inputDecoration({String? labelText}) {
  return InputDecoration(
    // ignore: prefer_const_constructors
    border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: radius()),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: radius()),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: colorPrimary),
        borderRadius: radius()),
    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: radius()),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: radius()),
    labelText: labelText,
    labelStyle: primaryTextStyle(),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    alignLabelWithHint: true,
  );
}

InputDecoration labelInputDecoration({String? labelText}) {
  return InputDecoration(
    focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: colorPrimary)),
    errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: colorPrimary)),
    errorStyle: TextStyle(color: colorPrimary.withOpacity(0.5)),
    labelStyle: TextStyle(color: colorPrimary.withOpacity(0.5)),
    labelText: labelText,
  );
}

Widget noDataWidget({String? errorMessage}) {
  return AppContainer(
    child: Text(
      textAlign: TextAlign.center,
      errorMessage.validate(value: appStore.translate('noDataFound')),
      style: AppFonts.bodyText1,
    ).center(),
  );
}

Widget loginWithOtpGoogleWidget(BuildContext context,
    {required String image, required String title}) {
  return AppContainer(
    width: context.width(),
    padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
    borderRadius: BorderRadius.circular(30),
    border: Border.all(color: AppColors.primaryColor),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 30, width: 30, fit: BoxFit.fill),
        8.width,
        Text(title, style: primaryTextStyle()),
      ],
    ),
  );
}

Widget viewCartWidget(
    {required BuildContext context, String? totalItemLength, Function? onTap}) {
  return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        width: context.width(),
        decoration: boxDecorationWithRoundedCorners(
            backgroundColor: AppColors.primaryColor),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${appStore.translate('total_item')} : $totalItemLength',
                style: primaryTextStyle(color: white)),
            Row(
              children: [
                Text(appStore.translate('checkout'),
                        style: primaryTextStyle(color: white))
                    .center(),
                const Icon(Icons.arrow_right, color: white, size: 20),
              ],
            )
          ],
        ),
      ).onTap(onTap,
          highlightColor:
              appStore.isDarkMode ? scaffoldColorDark : context.cardColor));
}

Widget otpNextWidget(BuildContext context, {Function? onTap}) {
  return Container(
    color: appStore.isDarkMode ? scaffoldColorDark : Colors.white,
    child: AppButton(
      onTap: onTap,
      color: colorPrimary,
      textStyle: boldTextStyle(color: white),
      width: context.width(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(appStore.translate('next'),
              style: boldTextStyle(color: Colors.white)),
          const Icon(
            Icons.navigate_next_outlined,
            color: white,
          )
        ],
      ),
    ),
  );
}
