import 'package:flutter/cupertino.dart';

class LandingViewModel extends ChangeNotifier {
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  List<String> boardingImages = [
    'assets/boarding1.jpg',
    'assets/boarding2.jpg',
    'assets/boarding3.jpg',
  ];

  List<String> boardingTitles = [
    ' اول ابلكيشن توصيل طلبات في ملوي \n  متاجر متنوعة.. خيارات لا تنتهي',
    'اختر منتجك، حدد موقعك، واستمتع بتجربة طلب مريحة.',
    'نلتزم بتوصيل طلباتك في أسرع وقت وبأفضل جودة.',
  ];

  updatePage(int value) {
    currentPage = value;
    print(currentPage);
  }
}
