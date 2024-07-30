import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderCustom extends StatefulWidget {
  final List items;
  final String item;
  final double height;
  final double aspectRatio;
  final double? viewportFraction;
  final int initialPage;
  final bool enableInfiniteScroll;
  final bool reverse;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final Curve autoPlayCurve;
  final bool enlargeCenterPage;
  final double enlargeFactor;
  final Function(int, CarouselPageChangedReason)? onPageChanged;
  final Axis scrollDirection;

  CarouselSliderCustom({
    required this.items,
    required this.item,
    this.height = 250,
    this.aspectRatio = 16 / 9,
    this.viewportFraction,
    this.initialPage = 0,
    this.enableInfiniteScroll = true,
    this.reverse = false,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.autoPlayCurve = Curves.fastOutSlowIn,
    this.enlargeCenterPage = true,
    this.enlargeFactor = 0.3,
    this.onPageChanged,
    this.scrollDirection = Axis.horizontal,
  });

  @override
  _CarouselSliderCustomState createState() => _CarouselSliderCustomState();
}

class _CarouselSliderCustomState extends State<CarouselSliderCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: CarouselSlider(
        items: widget.items as List<Widget>,
        options: CarouselOptions(
          height: widget.height,
          aspectRatio: widget.aspectRatio,
          viewportFraction: widget.viewportFraction ?? 2.0,
          initialPage: widget.initialPage,
          enableInfiniteScroll: widget.enableInfiniteScroll,
          reverse: widget.reverse,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: widget.autoPlayAnimationDuration,
          autoPlayCurve: widget.autoPlayCurve,
          enlargeCenterPage: widget.enlargeCenterPage,
          enlargeFactor: widget.enlargeFactor,
          onPageChanged: widget.onPageChanged,
          scrollDirection: widget.scrollDirection,
        ),
      ),
    );
  }
}

class ContainerItem extends StatelessWidget {
  final image;
  final height;
  final width;
  final padding;
  final margin;
  ContainerItem({required this.image, this.height,this.width,this.margin,this.padding});
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.amber,
      padding: padding,
      margin: margin,
      child: Image.asset(image,),
    );
  }
} 
