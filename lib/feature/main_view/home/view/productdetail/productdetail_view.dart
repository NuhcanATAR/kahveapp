import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/utility/base/main_view_base/home_base/home_base.dart';
import 'package:kahve/product/utility/database/home_db/home_db.dart';
import 'package:kahve/product/widget/text_widget/body_medium_text.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends MainHomeBaseState<ProductDetailView> {
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
          text: "Ürün Detayı",
          textAlign: TextAlign.center,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: FutureBuilder<DocumentSnapshot>(
              future:
                  HomeServiceDB.FAVORITE.productFavoriteRefTable(widget.data),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text(
                    "",
                  );
                }

                if (snapshot.hasData && !snapshot.data!.exists) {
                  return modelService.isFavoriteRemoveStatus != false
                      ? GestureDetector(
                          onTap: () {
                            productFavoriteDelete(widget.data);
                            setState(() {
                              modelService.isFavoriteRemoveStatus = true;
                            });
                          },
                          child: Icon(
                            Icons.favorite,
                            color: ColorBackgroundConstant.greenDarker,
                            size: 21,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            productFavoriteAdd(widget.data);
                            setState(() {
                              modelService.isFavoriteRemoveStatus = false;
                            });
                          },
                          child: Icon(
                            Icons.favorite_border,
                            color: ColorBackgroundConstant.greenDarker,
                            size: 21,
                          ),
                        );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return GestureDetector(
                    onTap: () {
                      productFavoriteDelete(widget.data);
                      setState(() {
                        modelService.isFavoriteAddStatus = false;
                      });
                    },
                    child: Icon(
                      Icons.favorite,
                      color: ColorBackgroundConstant.greenDarker,
                      size: 21,
                    ),
                  );
                } else {
                  return const Text("!");
                }
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: context.padding.low,
        child: Column(
          children: <Widget>[
            // main body
            buildMainBodyWidget(context, widget.data),
            // footer button
            buildFooterButtonWidget(context, widget.data),
          ],
        ),
      ),
    );
  }

  // main body
  Widget buildMainBodyWidget(context, data) => Expanded(
        child: ListView(
          children: <Widget>[
            // cover img
            buildCoverImg(context, data),
            // category
            buildCategoryWidget(context, data),
            // title
            buildTitleWidget(context, data),
            // sub title
            buildSubTitleWidget(context, data),
            // coffe product status select
            buildCoffeProductStatusSelect(context, data),
            // explanation
            buildExplanationWidget(context, data),
          ],
        ),
      );

  // cover img widget
  Widget buildCoverImg(context, data) => SizedBox(
        width: maxWidth,
        height: dynamicHeight(0.5),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                data['COVERIMG'],
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  // category
  Widget buildCategoryWidget(context, data) => Row(
        children: <Widget>[
          // main category
          FutureBuilder<DocumentSnapshot>(
            future: HomeServiceDB.MAINCATEGORY.productMainCategoryRef(data),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const SizedBox();
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return const SizedBox();
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> dataMainCategory =
                    snapshot.data!.data() as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () {
                    routerService.subCategoryListViewNavigatorRouter(
                      context,
                      dataMainCategory,
                    );
                  },
                  child: LabelMediumBlackText(
                    textAlign: TextAlign.left,
                    text: "${dataMainCategory['CATEGORYNAME']} / ",
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          // sub category
          FutureBuilder<DocumentSnapshot>(
            future: HomeServiceDB.SUBCATEGORY.productSubCategoryRef(data),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const SizedBox();
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return const SizedBox();
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> dataSubCategory =
                    snapshot.data!.data() as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () {
                    routerService.productListViewNavigatorRouter(
                      context,
                      dataSubCategory,
                    );
                  },
                  child: LabelMediumBlackText(
                    textAlign: TextAlign.left,
                    text: dataSubCategory['CATEGORYNAME'],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      );

  // title
  buildTitleWidget(context, data) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: BodyMediumBlackBoldText(
          textAlign: TextAlign.left,
          text: data['TITLE'],
        ),
      );

  // sub title
  buildSubTitleWidget(context, data) => Padding(
        padding: const EdgeInsets.only(top: 5),
        child: LabelMediumBlackBoldText(
          textAlign: TextAlign.left,
          text: data['SUBTITLE'],
        ),
      );

  // coffe product status select
  Widget buildCoffeProductStatusSelect(context, data) =>
      data['PRODUCTCOFFESTATUS'] == true
          ? Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                children: <Widget>[
                  // small
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (modelService.isSmallStatus == true) {
                            modelService.isSmallStatus = false;
                          } else {
                            modelService.isSmallStatus = true;
                          }
                          modelService.isMediumStatus = false;
                          modelService.isLargeStatus = false;
                        });
                      },
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: modelService.isSmallStatus == true
                                ? ColorBackgroundConstant.greenDarker
                                : Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.coffee,
                                color: modelService.isSmallStatus == true
                                    ? Colors.white
                                    : ColorBackgroundConstant.greenDarker,
                                size: 21,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              modelService.isSmallStatus == true
                                  ? const LabelMediumWhiteText(
                                      textAlign: TextAlign.center,
                                      text: "Küçük Boy",
                                    )
                                  : const LabelMediumMainColorText(
                                      textAlign: TextAlign.center,
                                      text: "Küçük Boy",
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // medium
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (modelService.isMediumStatus == true) {
                            modelService.isMediumStatus = false;
                          } else {
                            modelService.isMediumStatus = true;
                          }
                          modelService.isSmallStatus = false;
                          modelService.isLargeStatus = false;
                        });
                      },
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: modelService.isMediumStatus == true
                                ? ColorBackgroundConstant.greenDarker
                                : Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.coffee,
                                color: modelService.isMediumStatus == true
                                    ? Colors.white
                                    : ColorBackgroundConstant.greenDarker,
                                size: 21,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              modelService.isMediumStatus == true
                                  ? const LabelMediumWhiteText(
                                      textAlign: TextAlign.center,
                                      text: "Orta Boy",
                                    )
                                  : const LabelMediumMainColorText(
                                      textAlign: TextAlign.center,
                                      text: "Orta Boy",
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // large
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (modelService.isLargeStatus == true) {
                            modelService.isLargeStatus = false;
                          } else {
                            modelService.isLargeStatus = true;
                          }
                          modelService.isSmallStatus = false;
                          modelService.isMediumStatus = false;
                        });
                      },
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: modelService.isLargeStatus == true
                                ? ColorBackgroundConstant.greenDarker
                                : Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.coffee,
                                color: modelService.isLargeStatus == true
                                    ? Colors.white
                                    : ColorBackgroundConstant.greenDarker,
                                size: 21,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              modelService.isLargeStatus == true
                                  ? const LabelMediumWhiteText(
                                      textAlign: TextAlign.center,
                                      text: "Büyük Boy",
                                    )
                                  : const LabelMediumMainColorText(
                                      textAlign: TextAlign.center,
                                      text: "Büyük Boy",
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox();

  // explanation widget
  Widget buildExplanationWidget(context, data) => data['EXPLANATION'] == ""
      ? const SizedBox()
      : Column(
          children: <Widget>[
            // title
            SizedBox(
              width: maxWidth,
              child: const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: LabelMediumBlackBoldText(
                  text: "Ürün Hakkında",
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            // explanation
            SizedBox(
              width: maxWidth,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 55),
                child: LabelMediumBlackText(
                  text: data['EXPLANATION'],
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        );

  // footer button
  Widget buildFooterButtonWidget(context, data) => SizedBox(
        width: maxWidth,
        height: dynamicHeight(0.09),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              // price
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: BodyMediumBlackGreyText(
                  text:
                      "${data['SELLTYPE']} / ${modelService.isSmallStatus == true ? data['SMALLPRICE'].toString() : modelService.isMediumStatus == true ? data['MEDIUMPRICE'].toString() : modelService.isLargeStatus == true ? data['LARGEPRICE'].toString() : data['PRICE'].toString()}₺",
                  textAlign: TextAlign.left,
                ),
              ),
              // bakset add button
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    productBasketAdd(data);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: ColorBackgroundConstant.greenDarker,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        LabelMediumWhiteText(
                          text: "Sepete Ekle",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
