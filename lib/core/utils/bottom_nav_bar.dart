import 'package:flutter/material.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/main.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class SalomonBottomNav extends StatelessWidget {
  const SalomonBottomNav({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  final int currentIndex;

  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: AppColors.scaffoldColor,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home, size: 20),
            title:  Text(appStore.translate('home')),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.shopping_cart_rounded, size: 20),
            title: Text(appStore.translate('order')),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.add_shopping_cart_outlined, size: 20),
            title: Text(appStore.translate('cart')),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person_outline, size: 20),
            title: Text(appStore.translate('profile')),
          ),
        ],
      ),
    );
  }
}
