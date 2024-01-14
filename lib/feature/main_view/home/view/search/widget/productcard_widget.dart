import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/utility/database/search_db/search_db.dart';
import 'package:kahve/product/widget/text_widget/body_medium_text.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget(
      {required this.data,
      required this.routerService,
      required this.maxWidth,
      required this.dynamicHeight,
      super.key});

  final Map<String, dynamic> data;
  final dynamic routerService;
  final dynamic maxWidth;
  final dynamic dynamicHeight;

  @override
  Widget build(BuildContext context) {
    return buildProductCardWidget(context, data);
  }

  // product card widget
  Widget buildProductCardWidget(context, data) => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Card(
          child: SizedBox(
            width: maxWidth,
            height: dynamicHeight(0.15),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: Row(
                children: <Widget>[
                  // img
                  buildProductImgWidget(context, data),
                  // category & title & sub title & price
                  buildProductInformationWidget(context, data),
                ],
              ),
            ),
          ),
        ),
      );

  // product img
  Widget buildProductImgWidget(context, data) => Flexible(
        fit: FlexFit.tight,
        flex: 2,
        child: GestureDetector(
          onTap: () {
            routerService.productDetailViewNavigatorRouter(
              context,
              data,
            );
          },
          child: CachedNetworkImage(
            imageUrl: data['COVERIMG'],
            imageBuilder: (context, imageProvider) => Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              color: Colors.grey.withOpacity(0.1),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
        ),
      );

  // product category & title & sub title & price
  Widget buildProductInformationWidget(context, data) => Expanded(
        flex: 5,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // category
                SizedBox(
                  width: maxWidth,
                  child: FutureBuilder<DocumentSnapshot>(
                    future: SearchDB.MAINCATEGORY.productMainCategoryRef(data),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const SizedBox();
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return const SizedBox();
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> dataCategory =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return LabelMediumGreyText(
                          textAlign: TextAlign.left,
                          text: dataCategory['CATEGORYNAME'],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
                // title
                GestureDetector(
                  onTap: () {
                    routerService.productDetailViewNavigatorRouter(
                      context,
                      data,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: maxWidth,
                      child: BodyMediumBlackBoldText(
                        text: data['TITLE'],
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                // sub title
                GestureDetector(
                  onTap: () {
                    routerService.productDetailViewNavigatorRouter(
                      context,
                      data,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      width: maxWidth,
                      child: LabelMediumBlackText(
                        text: data['SUBTITLE'],
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                // price
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: maxWidth,
                    child: LabelMediumMainColorText(
                      text: "${data['PRICE']}₺",
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
