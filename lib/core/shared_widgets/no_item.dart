import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/config/style/app_fonts.dart';

class NoItem extends StatelessWidget {
  const NoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No Items', style: AppFonts.bodyText4),
    );
  }
}
