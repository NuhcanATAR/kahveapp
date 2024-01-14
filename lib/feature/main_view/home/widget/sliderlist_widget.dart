import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/utility/database/home_db/home_db.dart';

class SliderListWidget extends StatelessWidget {
  const SliderListWidget({
    required this.maxWidth,
    required this.dynamicHeight,
    super.key,
  });

  final dynamic maxWidth;
  final dynamic dynamicHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth,
      height: dynamicHeight(0.17),
      child: StreamBuilder<QuerySnapshot>(
        stream: HomeServiceDB.BANNERS.appBannerSliderList,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return buildErrorSliderCardWidget;
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoadingSliderCardWidget;
          }

          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.docs.isNotEmpty) {
            return CarouselSlider(
              items: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return buildBannerCardWidget(context, data);
              }).toList(),
              options: CarouselOptions(
                autoPlay: false,
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  // error slider card widget
  Widget get buildErrorSliderCardWidget => Card(
        child: SizedBox(
          width: maxWidth,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          ),
        ),
      );

  // loading slider card widget
  Widget get buildLoadingSliderCardWidget => Card(
        child: SizedBox(
          width: maxWidth,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          ),
        ),
      );

  // banner card widget
  Widget buildBannerCardWidget(context, data) => GestureDetector(
        onTap: () {},
        child: Card(
          child: SizedBox(
            width: maxWidth,
            child: CachedNetworkImage(
              imageUrl: data['IMG'].toString(),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
              ),
              placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
