import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/utility/database/basket_db/basket_db.dart';
import 'package:kahve/product/widget/text_widget/body_medium_text.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    required this.data,
    required this.maxWidth,
    required this.dynamicHeight,
    required this.routerService,
    required this.alertBasketProductRemoveDialog,
    required this.basketSelectProductDelete,
    required this.basketSelectProductQuanityAdd,
    required this.basketSelectProductQuanityDecreasing,
    super.key,
  });

  final Map<String, dynamic> data;
  final dynamic maxWidth;
  final dynamic dynamicHeight;
  final dynamic routerService;
  final dynamic alertBasketProductRemoveDialog;
  final dynamic basketSelectProductDelete;
  final dynamic basketSelectProductQuanityAdd;
  final dynamic basketSelectProductQuanityDecreasing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Card(
        child: SizedBox(
          width: maxWidth,
          height: dynamicHeight(0.18),
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
  }

  // product img
  Widget buildProductImgWidget(context, data) => Flexible(
        fit: FlexFit.tight,
        flex: 2,
        child: FutureBuilder<DocumentSnapshot>(
          future: BasketDB.PRODUCTS.productRef(data),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const SizedBox();
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const SizedBox();
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> dataProduct =
                  snapshot.data!.data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  routerService.productDetailViewNavigatorRouter(
                    context,
                    dataProduct,
                  );
                },
                child: CachedNetworkImage(
                  imageUrl: data['PRODUCTIMG1'],
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
              );
            } else {
              return const SizedBox();
            }
          },
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
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FutureBuilder<DocumentSnapshot>(
                          future: BasketDB.MAINCATEGORY
                              .productMainCategoryRef(data),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const SizedBox();
                            }

                            if (snapshot.hasData && !snapshot.data!.exists) {
                              return const SizedBox();
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.done) {
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
                      GestureDetector(
                        onTap: () {
                          alertBasketProductRemoveDialog(
                            context,
                            basketSelectProductDelete,
                            data,
                          );
                        },
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                // title
                FutureBuilder<DocumentSnapshot>(
                  future: BasketDB.PRODUCTS.productRef(data),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const SizedBox();
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return const SizedBox();
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> dataProduct =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          routerService.productDetailViewNavigatorRouter(
                            context,
                            dataProduct,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: maxWidth,
                            child: BodyMediumBlackBoldText(
                              text: data['PRODUCTTITLE'],
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                // sub title
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    width: maxWidth,
                    child: LabelMediumBlackText(
                      text: data['PRODUCTSUBTITLE'],
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                // coffe size type
                data['PRODUCTCOFFESTATUS'] == true
                    ? Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SizedBox(
                          width: maxWidth,
                          child: LabelMediumBlackText(
                            text:
                                "Boyut: ${data['COFFESMALLSTATUS'] == true ? "Küçük Boy" : data['COFFEMEDIUMSTATUS'] == true ? "Orta Boy" : "Büyük Boy"}",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      )
                    : const SizedBox(),

                // quanity select & total price product
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: <Widget>[
                      // qunity select value
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                basketSelectProductQuanityAdd(data);
                              },
                              child: const Card(
                                margin: EdgeInsets.only(right: 5),
                                color: Colors.white,
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: LabelMediumBlackText(
                                text: data['QUANITY'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                basketSelectProductQuanityDecreasing(data);
                              },
                              child: const Card(
                                margin: EdgeInsets.only(left: 5),
                                color: Colors.white,
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // product total price
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: LabelMediumMainColorText(
                            text: "${data['TOTALPRICE'].toString()}₺",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
