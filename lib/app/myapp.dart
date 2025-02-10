import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/AppLocalizations.dart';
import 'package:fooddelivery/config/style/app_themes.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/modules/SplashScreen.dart';
import 'package:fooddelivery/modules/home/view_model/home_view_model.dart';
import 'package:fooddelivery/modules/layout/view_model/layout_view_model.dart';
import 'package:fooddelivery/modules/orders/view_model/order_details_view_model.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    setOrientationPortrait();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LayoutViewModel()..init(context),
        ),
        ChangeNotifierProvider(
            create: (_) => HomeViewModel()..homeInit(context)),
        ChangeNotifierProvider(
          create: (_) => OrderDetailsViewModel(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => Observer(
          builder: (_) => MaterialApp(
            title: mAppName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            locale: Locale(appStore.selectedLanguage),
            supportedLocales: LanguageDataModel.languageLocales(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            localeResolutionCallback: (locale, supportedLocales) => locale,
            home: const SplashScreen(),
            builder: scrollBehaviour(),
          ),
        ),
      ),
    );
  }
}
