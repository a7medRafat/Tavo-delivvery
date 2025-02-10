import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class Carousel extends StatelessWidget {
  const Carousel({
    super.key,
    required this.itemCount,
    required this.images,
  });

  final int itemCount;
  final List images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Image.network(
              fit: BoxFit.cover, width: MediaQuery.of(context).size.width, images[itemIndex]),
      options: CarouselOptions(
          autoPlay: false,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          enlargeFactor: 0.3,
          viewportFraction: 1,
          enableInfiniteScroll: true,
          scrollDirection: Axis.horizontal,
          padEnds: false,
          onPageChanged: (index, reason) {}),
    );
  }
}
