import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/home/view/category/view/categoryerror_view.dart';
import 'package:kahve/feature/main_view/home/view/category/view/categoryloading_view.dart';
import 'package:kahve/feature/main_view/home/view/category/view/nocategory_view.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/enums/category_enums.dart';
import 'package:kahve/product/utility/base/main_view_base/home_base/home_base.dart';
import 'package:kahve/product/utility/database/home_db/home_db.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class SubCategoryListView extends StatefulWidget {
  const SubCategoryListView({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  State<SubCategoryListView> createState() => _SubCategoryListViewState();
}

class _SubCategoryListViewState extends MainHomeBaseState<SubCategoryListView> {
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
        title: LabelMediumMainColorText(
          text: widget.data['CATEGORYNAME'],
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: context.padding.low,
        child: StreamBuilder<QuerySnapshot>(
          stream: HomeServiceDB.SUBCATEGORY.subCategoryList(widget.data),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return CategoryErrorView(
                title: CategoryEnums.errorSubCategoryTitleText.value,
                subTitle: CategoryEnums.errorSubCategorySubTitleText.value,
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CategoryLoadingView(
                title: CategoryEnums.loadingCategoryTitleText.value,
                subTitle: CategoryEnums.loadingCategorySubTitleText.value,
              );
            }

            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.docs.isNotEmpty) {
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return buildCardWidget(context, data);
                }).toList(),
              );
            } else {
              return NoCategoryView(
                title: CategoryEnums.noSubCategoryTitleText.value,
                subTitle: CategoryEnums.noSubCategorySubTitleText.value,
              );
            }
          },
        ),
      ),
    );
  }

  // card widget
  Widget buildCardWidget(context, data) => Padding(
        padding: const EdgeInsets.only(top: 15),
        child: GestureDetector(
          onTap: () {
            routerService.productListViewNavigatorRouter(context, widget.data);
          },
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: LabelMediumBlackBoldText(
                        text: data['CATEGORYNAME'],
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: ColorBackgroundConstant.greenDarker,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
