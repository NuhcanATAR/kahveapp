import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/enums/home_enums.dart';
import 'package:kahve/product/utility/database/home_db/home_db.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class ShowCaseListWidget extends StatelessWidget {
  const ShowCaseListWidget(
      {required this.maxWidth,
      required this.dynamicWidth,
      required this.dynamicHeight,
      super.key});

  final dynamic maxWidth;
  final dynamic dynamicWidth;
  final dynamic dynamicHeight;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: HomeServiceDB.PRODUCTS.productShowCaseList,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const SizedBox();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }

        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.docs.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              children: <Widget>[
                // title
                SizedBox(
                  width: maxWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 15),
                    child: LabelMediumBlackBoldText(
                      text: HomeStrings.showCaseTitleText.value,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                // list
                SizedBox(
                  width: maxWidth,
                  height: dynamicHeight(0.4),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      if (data['SHOWCASESTATUS'] == true &&
                          data['ACTIVE'] == true) {
                        return buildProductCardWidget(context, data);
                      } else {
                        return const SizedBox();
                      }
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  // product card widget
  Widget buildProductCardWidget(context, data) => GestureDetector(
        onTap: () {},
        child: Card(
          child: SizedBox(
            width: dynamicWidth(0.47),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    // cover ımg
                    buildCoverImgWidget(context, data),
                    // title
                    buildTitleWidget(context, data),
                    // sub title
                    buildSubTitleWidget(context, data),
                    // price
                    buildPriceWidget(context, data),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  // cover ımg widget
  Widget buildCoverImgWidget(context, data) => SizedBox(
        width: maxWidth,
        height: dynamicHeight(0.24),
        child: CachedNetworkImage(
          imageUrl: data['COVERIMG'].toString(),
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
              color: Colors.grey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          ),
        ),
      );

  // title widget
  Widget buildTitleWidget(context, data) => SizedBox(
        width: maxWidth,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: LabelMediumBlackBoldText(
            text: data['TITLE'],
            textAlign: TextAlign.left,
          ),
        ),
      );

  // sub title widget
  Widget buildSubTitleWidget(context, data) => SizedBox(
        width: maxWidth,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: LabelMediumBlackText(
            text: data['SUBTITLE'],
            textAlign: TextAlign.left,
          ),
        ),
      );

  // price widget
  Widget buildPriceWidget(context, data) => SizedBox(
        width: maxWidth,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: LabelMediumMainColorText(
            text: "${data['PRICE'].toString()}₺",
            textAlign: TextAlign.left,
          ),
        ),
      );
}
