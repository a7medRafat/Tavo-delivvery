import 'package:flutter/material.dart';
import 'package:fooddelivery/config/style/app_fonts.dart';

class CategoryLanding extends StatelessWidget {
  final IconData icon;
  final String title;

  const CategoryLanding({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.grey[200]),
        const SizedBox(height: 4),
        Text(title, style: AppFonts.bodyText1),
      ],
    );
  }
}
