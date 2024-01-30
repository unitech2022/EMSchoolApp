import 'package:cached_network_image/cached_network_image.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

import '../../../../../../../core/utlis/api_constatns.dart';
import '../../../../../../common/models/bunner_model.dart';

class CarouselWidget extends StatefulWidget {
  final List<BannerModel> bunners;
  const CarouselWidget({
    super.key,
    required this.bunners,
  });

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return  widget.bunners.isEmpty?const SizedBox():  CarouselSlider.builder(
      options: CarouselOptions(
        onPageChanged: (newIndex, car) {
          index = newIndex;
          setState(() {});
        },
        // aspectRatio: 0,
        //  enlargeCenterPage: true,
        aspectRatio: .9,
        viewportFraction:1,
        scrollDirection: Axis.horizontal,
        height: 180,
        autoPlay:widget.bunners.length==1?false: true,
        reverse: true,
        enableInfiniteScroll: true,
        initialPage: 0,
      ),
      itemCount: widget.bunners.length,
      itemBuilder:
          (BuildContext context, int itemIndex, int pageViewIndex) {
        BannerModel offerModel = widget.bunners[itemIndex];
        return InkWell(
          onTap: () {},
          child: Container(
            height: 150,
            width: double.infinity,
            decoration:  const BoxDecoration(
               // borderRadius: BorderRadius.circular(15)
                ),
            child: ClipRRect(
                // borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
              imageUrl: ApiConstants.imageUrl(offerModel.image),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )),
          ),
        );
      },
    );
  }
}
