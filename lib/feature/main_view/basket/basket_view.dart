import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/basket/view/basketcontrol_view/basketerror_view.dart';
import 'package:kahve/feature/main_view/basket/view/basketcontrol_view/basketloading_view.dart';
import 'package:kahve/feature/main_view/basket/view/basketcontrol_view/noproductbasket_view.dart';
import 'package:kahve/feature/main_view/basket/widget/footerbutton_widget.dart';
import 'package:kahve/feature/main_view/basket/widget/productcard_widget.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/enums/basket_enums.dart';
import 'package:kahve/product/utility/base/main_view_base/basket_base/basket_base.dart';
import 'package:kahve/product/utility/database/basket_db/basket_db.dart';
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
            return ProductCardWidget(
              data: data,
              maxWidth: maxWidth,
              dynamicHeight: dynamicHeight,
              routerService: routerService,
              alertBasketProductRemoveDialog: alertBasketProductRemoveDialog,
              basketSelectProductDelete: basketSelectProductDelete,
              basketSelectProductQuanityAdd: basketSelectProductQuanityAdd,
              basketSelectProductQuanityDecreasing:
                  basketSelectProductQuanityDecreasing,
            );
          }).toList(),
        ),
      );

  // footer button
  Widget get buildFooterButtonWidget => FooterButtonWidget(
        maxWidth: maxWidth,
        dynamicHeight: dynamicHeight,
        basketQuanityAndTotalPriceControl: basketQuanityAndTotalPriceControl,
      );
}
