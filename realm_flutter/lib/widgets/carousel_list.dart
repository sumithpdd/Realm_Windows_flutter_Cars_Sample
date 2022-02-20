// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/model.dart';
import 'carousel_card.dart';

class CarouselList extends StatefulWidget {
  const CarouselList({Key? key, required this.cars}) : super(key: key);
  final List<Car> cars;
  @override
  _CarouselListState createState() => _CarouselListState();
}

class _CarouselListState extends State<CarouselList> {
  int currentPage = 0;

  // Widget updateIndicators() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: widget.cars.map(
  //       (car) {
  //         var index = widget.cars.indexOf(car);
  //         return Container(
  //           width: 7.0,
  //           height: 7.0,
  //           margin: EdgeInsets.symmetric(horizontal: 6.0),
  //           decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             color: currentPage == index ? Colors.red : Color(0xFFA6AEBD),
  //           ),
  //         );
  //       },
  //     ).toList(),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: <Widget>[
  //       Spacer(),
  //       SizedBox(
  //         height: MediaQuery.of(context).size.height * 0.6,
  //         width: double.infinity,
  //         child: PageView.builder(
  //           itemBuilder: (context, index) {
  //             return Opacity(
  //               opacity: currentPage == index ? 1.0 : 0.8,
  //               child: CarouselCard(
  //                 car: widget.cars[index],
  //               ),
  //             );
  //           },
  //           itemCount: widget.cars.length,
  //           controller: PageController(initialPage: 0, viewportFraction: 0.75),
  //           onPageChanged: (index) {
  //             setState(() {
  //               currentPage = index;
  //             });
  //           },
  //         ),
  //       ),
  //       updateIndicators(),
  //       Spacer(),
  //     ],
  //   );
  // }
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: widget.cars.map((car) {
          return Builder(
            builder: (BuildContext context) {
              return CarouselCard(car: car);
            },
          );
        }).toList(),
        options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.6,
            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: false,
            reverse: false,
            enlargeCenterPage: false,
            initialPage: 0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.cars.map(
          (car) {
            int index = widget.cars.indexOf(car);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? kCourseElementIconColor
                      : Color.fromRGBO(0, 0, 0, 0.4)),
            );
          },
        ).toList(),
      ),
    ]);
  }
}
