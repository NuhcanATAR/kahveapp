import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:kahve/product/enums/home_enums.dart';
import 'package:kahve/product/utility/database/home_db/home_db.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({
    required this.maxWidth,
    required this.dynamicHeight,
    super.key,
  });

  final dynamic maxWidth;
  final dynamic dynamicHeight;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: HomeServiceDB.MAINCATEGORY.mainCategoryList,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const SizedBox();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }

        return Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: <Widget>[
              // title
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: LabelMediumBlackBoldText(
                        text: HomeStrings.categoryTitleText.value,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: LabelMediumMainColorText(
                        text: HomeStrings.categoryNextText.value,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              // list
              SizedBox(
                width: maxWidth,
                height: dynamicHeight(0.09),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 25,
                                  height: 50,
                                  child: CachedNetworkImage(
                                    imageUrl: data['ICON'].toString(),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        const SizedBox(),
                                    errorWidget: (context, url, error) =>
                                        const SizedBox(),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, right: 5),
                                  child: LabelMediumBlackBoldText(
                                    text: data['CATEGORYNAME'].toString(),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
