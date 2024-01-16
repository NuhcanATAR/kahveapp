import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/basket/view/basketcontrol_view/basketerror_view.dart';
import 'package:kahve/feature/main_view/basket/view/basketcontrol_view/basketloading_view.dart';
import 'package:kahve/feature/main_view/basket/view/basketcontrol_view/noproductbasket_view.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/enums/basket_enums.dart';
import 'package:kahve/product/utility/base/main_view_base/basket_base/basket_base.dart';
import 'package:kahve/product/utility/database/basket_db/basket_db.dart';
import 'package:kahve/product/utility/service/firebase_service.dart';
import 'package:kahve/product/widget/text_widget/body_medium_text.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends MainBasketBase<BasketView> {
  int totalValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorBackgroundConstant.greenDarker,
            size: 20,
          ),
        ),
        title: const LabelMediumMainColorText(
          text: "Sepet",
          textAlign: TextAlign.center,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: BasketDB.BASKET.productBasketListQuery,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return BasketErrorView(
              title: BasketStrings.basketErrorTitleText.value,
              description: BasketStrings.basketErrorDescriptionText.value,
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return BasketLoadingView(
              title: BasketStrings.basketLoadingTitleText.value,
              description: BasketStrings.basketLoadingDescriptionText.value,
            );
          }

          List<DocumentSnapshot> productList = snapshot.data!.docs;

          if (snapshot.hasData &&
              snapshot.data != null &&
              productList.isNotEmpty) {
            return Padding(
              padding: context.padding.low,
              child: Column(
                children: <Widget>[
                  // main body
                  buildMainBodyWidget(context, productList),
                  // footer button
                  buildFooterButtonWidget,
                ],
              ),
            );
          } else {
            return NoProductBasketView(
              title: BasketStrings.basketNoProductTitleText.value,
              description: BasketStrings.basketNoProductDescriptionText.value,
            );
          }
        },
      ),
    );
  }

  // main body
  Widget buildMainBodyWidget(context, List<DocumentSnapshot> productList) =>
      Expanded(
        child: ListView(
          children: productList.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
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
          }).toList(),
        ),
      );

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

  // footer button
  Widget get buildFooterButtonWidget => SizedBox(
        width: maxWidth,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: <Widget>[
              // total quanity
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: LabelMediumGreyText(
                        text: "Toplam Adet",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("BASKET")
                          .doc(FirebaseService().authID)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const SizedBox(); // Hata durumunda boş bir widget dönebilirsiniz
                        }

                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return const LabelMediumBlackBoldText(
                            textAlign: TextAlign.center,
                            text: "0",
                          );
                        }

                        Map<String, dynamic>? data =
                            snapshot.data!.data() as Map<String, dynamic>?;
                        int totalQuantity = data?['TOTALQUANITY'] ?? 0;

                        return LabelMediumBlackBoldText(
                          textAlign: TextAlign.center,
                          text: "( $totalQuantity )",
                        );
                      },
                    ),
                  ],
                ),
              ),
              // total price
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: LabelMediumGreyText(
                        text: "Toplam Fiyat",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("BASKET")
                          .doc(FirebaseService().authID)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const SizedBox(); // Hata durumunda boş bir widget dönebilirsiniz
                        }

                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return const LabelMediumBlackBoldText(
                            textAlign: TextAlign.center,
                            text: "0",
                          );
                        }

                        Map<String, dynamic>? data =
                            snapshot.data!.data() as Map<String, dynamic>?;
                        num totalQuantity = data?['TOTALPRICE'] ?? 0;

                        return LabelMediumBlackBoldText(
                          textAlign: TextAlign.center,
                          text: "$totalQuantity₺",
                        );
                      },
                    ),
                  ],
                ),
              ),
              // next button
              GestureDetector(
                onTap: () {
                  basketQuanityAndTotalPriceControl();
                },
                child: SizedBox(
                  width: maxWidth,
                  height: dynamicHeight(0.08),
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: ColorBackgroundConstant.greenDarker,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: const LabelMediumWhiteText(
                      text: "Devam Et",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
