import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fooddelivery/components/ThemeSelectionDialog.dart';
import 'package:fooddelivery/modules/MyAddressScreen.dart';
import 'package:fooddelivery/services/AuthService.dart';
import 'package:fooddelivery/utils/Common.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:fooddelivery/utils/functions.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share/share.dart';

import '../main.dart';
import 'EditProfileScreen.dart';
import 'FavouriteRestaurantListScreen.dart';
import 'LoginScreen.dart';

class ProfileFragment extends StatefulWidget {
  static String tag = '/ProfileFragment';

  const ProfileFragment({super.key});

  @override
  ProfileFragmentState createState() => ProfileFragmentState();
}

class ProfileFragmentState extends State<ProfileFragment> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
//
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    appStore.setAppLocalization(context);

    return Scaffold(
      body: Observer(
        builder: (_) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              Row(
                children: [
                  appStore.userProfileImage.validate().isEmpty
                      ? const Icon(Icons.person_outline, size: 60)
                      : cachedImage(
                          appStore.userProfileImage.validate(),
                          usePlaceholderIfUrlEmpty: true,
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ).cornerRadiusWithClipRRect(defaultRadius),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(appStore.userFullName.validate(),
                          style: boldTextStyle()),
                      Text(appStore.userEmail.validate(),
                          style: secondaryTextStyle()),
                    ],
                  ),
                ],
              ).paddingOnly(left: 16, right: 16).onTap(() {
                EditProfileScreen().launch(context);
              }).visible(appStore.isLoggedIn),
              16.height,
              const Divider(height: 0),
              SettingItemWidget(
                leading: const Icon(MaterialCommunityIcons.theme_light_dark),
                title: appStore.translate('select_theme'),
                onTap: () async {
                  await showInDialog(
                    context,
                    child: ThemeSelectionDialog(),
                    contentPadding: EdgeInsets.zero,
                    title: Text(appStore.translate('select_theme'),
                        style: primaryTextStyle(size: 20)),
                  );
                  setState(() {});
                },
              ),
              const Divider(height: 0),
              SettingItemWidget(
                title: appStore.translate('fav_restaurant'),
                leading: const Icon(Icons.restaurant_outlined),
                onTap: () {
                  if (appStore.isLoggedIn) {
                    FavouriteRestaurantListScreen().launch(context);
                  } else {
                    const LoginScreen().launch(context);
                  }
                },
              ),
              const Divider(height: 0),
              SettingItemWidget(
                title: appStore.translate('my_address'),
                leading: const Icon(Icons.book_outlined),
                onTap: () {
                  if (appStore.isLoggedIn) {
                    MyAddressScreen().launch(context);
                  } else {
                    const LoginScreen().launch(context);
                  }
                },
              ),
              const Divider(height: 0),
              SettingItemWidget(
                title: appStore.translate('app_lang'),
                leading: const Icon(FontAwesome.language),
                trailing: Row(
                  children: [
                    Image.asset(selectedLanguageDataModel!.flag.validate(),
                        height: 25, width: 25),
                    4.width,
                    Text(selectedLanguageDataModel!.name.validate(),
                        style: boldTextStyle()),
                  ],
                ),
                onTap: () async {
                  await StatefulBuilder(builder: (context, setState) {
                    return Scaffold(
                      appBar: appBarWidget(appStore.translate('app_lang'),
                          color: context.cardColor),
                      body: LanguageListWidget(
                        onLanguageChange: (val) async {
                          appStore.setLanguage(val.languageCode.validate());
                          await setValue(
                              SELECTED_LANGUAGE_CODE, val.languageCode);

                          finish(context);
                        },
                      ),
                    );
                  }).launch(context);

                  setState(() {});
                },
              ),
              const Divider(height: 0),
              SettingItemWidget(
                leading: const Icon(Icons.share_outlined),
                title: '${appStore.translate('share')} $mAppName',
                onTap: () {
                  PackageInfo.fromPlatform().then((value) {
                    String package = '';
                    if (isAndroid) package = value.packageName;

                    Share.share(
                        '${appStore.translate('share')} $mAppName\n\n${storeBaseURL()}$package');
                  });
                },
              ),
              const Divider(height: 0),
              SettingItemWidget(
                leading: const Icon(Icons.support_rounded),
                title: appStore.translate('help_support'),
                onTap: () {
                  AppFunctions.launchWhatsApp();
                },
              ),
              const Divider(height: 0),
              SettingItemWidget(
                title: appStore.translate('logout'),
                leading: const Icon(Icons.logout),
                onTap: () async {
                  bool? res = await showConfirmDialog(
                    context,
                    appStore.translate('do_you_want_to_logout'),
                    negativeText: appStore.translate('no'),
                    positiveText: appStore.translate('yes'),
                  );
                  if (res ?? false) {
                    logout().then((value) {
                      const LoginScreen().launch(context, isNewTask: true);
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
