import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery/config/style/app_fonts.dart';
import 'package:fooddelivery/core/utils/vContainer.dart';

class OffersLanding extends StatelessWidget {
  const OffersLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Column(
        children: [
          Text("تعرف على عروضنا وخصوماتنا اليومية",
              textAlign: TextAlign.center, style: AppFonts.bodyText1),
          const SizedBox(height: 10),
          Image.asset(
            "assets/off1.jpg",
            width: double.infinity,
            height: 250.h,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Image.asset(
            "assets/off2.jpg",
            width: double.infinity,
            height: 250.h,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
