import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class MyCarousel extends StatelessWidget {
  const MyCarousel({
    super.key,
    required this.images,
  });

  final List images;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const Center(
        child: Text(
          "No images available",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Image.network(
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        images[itemIndex],
      ),
      options: CarouselOptions(
          autoPlay: true,
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
