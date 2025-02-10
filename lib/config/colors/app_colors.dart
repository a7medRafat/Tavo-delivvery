import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AppColors {
  static Color scaffoldColor = const Color(0xfff6f6f6);
  static Color caption = const Color(0xff8f8e8e);
  static Color valux = const Color(0xff000000);
  static Color darkGray = const Color(0xff626161);
  static Color bodyTxt = Colors.black;
  static Color vBlue = Colors.blue;
  static Color iconColor = Colors.black;
  static Color titles = Colors.black;
  static Color body = Colors.black;
  static Color offColor = Colors.black;
  static Color vGray = Colors.grey;
  static Color vWhite = Colors.white;
  static Color vRed = Colors.redAccent;
  static Color bodySmall = const Color(0xff848484);
  static Color vBottomNavColor = Colors.white;
  static Color confirmation = const Color(0xff4fb737);

  static Color primaryColor = const Color(0xFFff6b31);
  static Color scaffoldColorDark = const Color(0xFF111111);
  static Color scaffoldSecondaryDark = const Color(0xFF1E1E1E);
  static Color appButtonColorDark = const Color(0xFF282828);
  static Color grayColor = const Color(0xFF757575);

  static Color scaffoldLightColor = const Color(0xFFEBF2F7);
  static Color scaffoldDarkColor = const Color(0xFF0E1116);
  static Color cardDarkColor = const Color(0xFF1C1F26);
  static Color dividerDarkColor = const Color(0xFF393D45);
  static Color cardLightColor = const Color(0xFFF6F7F9);

  static Color textPrimaryColor = const Color(0xFF2E3033);
  static Color textSecondaryColor = const Color(0xFF757575);
  static Color viewLineColor = const Color(0xFFEAEAEA);
  static Color errorColor = const Color(0xFFFF6347);
  static Color transparentColor = const Color(0x00000000);

  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;

  /// Returns MaterialColor from Color
  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }


  /// Light Colors
  List<Color> lightColors = [
    mistyRose,
    whiteSmoke,
    linen,
    const Color(0xffcffada),
    const Color(0xFFf0efeb),
    const Color(0xffd4dffa),
    const Color(0xfff8eadf),
    const Color(0xfffcdce1),
    const Color(0xffddf8fa),
    const Color(0xfffcfade),
    const Color(0xffe2f8d8),
    const Color(0xfffdf2e8),
    const Color(0xffece8fd),
    const Color(0xffdcfaf2),
  ];
}
