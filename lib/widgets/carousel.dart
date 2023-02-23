import 'package:carousel_slider/carousel_slider.dart';
import 'package:elector/constants/constants.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<String> images = [
    'assets/images/carousel1.png',
    'assets/images/carousel2.png',
    'assets/images/carousel3.png',
    'assets/images/carousel4.png',
    'assets/images/carousel5.png',
  ];

  List<Widget> generateImagesTiles() {
    return images
        .map((e) => ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                e,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          CarouselSlider(
            items: generateImagesTiles(),
            options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == entry.key
                          ? kMainThemeColor
                          : Color(0xFFD0CDCD)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
