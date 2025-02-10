import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/config/style/app_fonts.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/utils/Common.dart';
import 'package:nb_utils/nb_utils.dart';

class UserNameImageAddress extends StatelessWidget {
  const UserNameImageAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        appStore.userProfileImage.validate().isEmpty
            ? const Icon(Icons.person_outline, size: 30)
            : cachedImage(
                appStore.userProfileImage.validate(),
                usePlaceholderIfUrlEmpty: true,
                height: 60.h,
                width: 60.w,
                fit: BoxFit.cover,
              ).cornerRadiusWithClipRRect(5),
        10.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${appStore.translate('hello')}, ${appStore.userFullName.validate()} ',
                style: AppFonts.headline3),
            Text(
              userAddressGlobal.validate().isEmpty
                  ? 'no address'
                  : userAddressGlobal,
              style: AppFonts.bodyText1,
            ),
          ],
        ).visible(appStore.isLoggedIn).expand(),
      ],
    ).paddingAll(16).visible(appStore.isLoggedIn);
  }
}
