import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/home/view/productlist/view/noproduct_view.dart';
import 'package:kahve/feature/main_view/home/view/productlist/view/producterror_view.dart';
import 'package:kahve/feature/main_view/home/view/productlist/view/productloading_view.dart';
import 'package:kahve/feature/main_view/home/view/search/widget/productcard_widget.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/enums/productlist_enums.dart';
import 'package:kahve/product/utility/base/main_view_base/home_base/home_base.dart';
import 'package:kahve/product/utility/database/home_db/home_db.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends MainHomeBaseState<ProductListView> {
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
          text: "Ürün Listesi",
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: context.padding.low,
        child: StreamBuilder<QuerySnapshot>(
          stream: HomeServiceDB.PRODUCTS.subCategoryProductList(widget.data),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return ErrorProductView(
                title: ProductListEnums.errorTitleText.value,
                subTitle: ProductListEnums.errorSubTitleText.value,
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingProductView(
                title: ProductListEnums.loadingTitleText.value,
                subTitle: ProductListEnums.loadingSubTitleText.value,
              );
            }

            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.docs.isNotEmpty) {
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> dataProduct =
                      document.data()! as Map<String, dynamic>;
                  return ProductCardWidget(
                    data: dataProduct,
                    routerService: routerService,
                    maxWidth: maxWidth,
                    dynamicHeight: dynamicHeight,
                  );
                }).toList(),
              );
            } else {
              return NoProductView(
                title: ProductListEnums.noTitleText.value,
                subTitle: ProductListEnums.noSubTitleText.value,
              );
            }
          },
        ),
      ),
    );
  }
}
