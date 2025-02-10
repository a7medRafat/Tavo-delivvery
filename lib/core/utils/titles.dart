import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/main.dart';
import 'package:nb_utils/nb_utils.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(appStore.translate(text), style: boldTextStyle(size: 16))
        .paddingRight(15)
        .paddingLeft(16);
  }
}
