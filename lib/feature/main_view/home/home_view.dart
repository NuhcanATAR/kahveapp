import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/home/widget/bloglist_widget.dart';
import 'package:kahve/feature/main_view/home/widget/categorylist_widget.dart';
import 'package:kahve/feature/main_view/home/widget/search_widget.dart';
import 'package:kahve/feature/main_view/home/widget/showcaselist_widget.dart';
import 'package:kahve/feature/main_view/home/widget/sliderlist_widget.dart';
import 'package:kahve/feature/main_view/home/widget/welcometext_widget.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/constants/img_constants.dart';
import 'package:kahve/product/enums/home_enums.dart';
import 'package:kahve/product/utility/base/main_view_base/home_base/home_base.dart';
import 'package:kahve/product/utility/database/home_db/home_db.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends MainHomeBaseState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                width: 40,
                height: 40,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: AppHomeViewImageConstant.profileIMG.toImg,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  // welcome text
                  SizedBox(
                    width: maxWidth,
                    child: LabelMediumGreyText(
                      text: HomeStrings.welcomeText.value,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  // name surname
                  FutureBuilder<DocumentSnapshot>(
                    future: HomeServiceDB.USERS.userRefTable,
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const SizedBox();
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return const SizedBox();
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return SizedBox(
                          width: maxWidth,
                          child: LabelMediumBlackBoldText(
                            text: "${data['NAMESURNAME']}",
                            textAlign: TextAlign.left,
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.notifications,
              color: ColorBackgroundConstant.greenDarker,
              size: 20,
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          // welcome text
          buildWelcomeTextWidget,
          // search
          buildSearchWidget,
          // category list
          buildCategoryListWidget,
          // slider list
          buildSliderListWidget,
          // show case list
          buildShowCaseListWidget,
          // blog list
          buildBlogListWidget,
        ],
      ),
    );
  }

  // welcome text
  Widget get buildWelcomeTextWidget => const WelcomeTextWidget();

  // search
  Widget get buildSearchWidget => SearchWidget(
        maxWidth: maxWidth,
        dynamicHeight: dynamicHeight,
      );

  // category list
  Widget get buildCategoryListWidget => CategoryListWidget(
        maxWidth: maxWidth,
        dynamicHeight: dynamicHeight,
      );

  // slider list
  Widget get buildSliderListWidget => SliderListWidget(
        maxWidth: maxWidth,
        dynamicHeight: dynamicHeight,
      );

  // show case list
  Widget get buildShowCaseListWidget => ShowCaseListWidget(
        maxWidth: maxWidth,
        dynamicWidth: dynamicWidth,
        dynamicHeight: dynamicHeight,
      );

  // blog list
  Widget get buildBlogListWidget => BlogListWidget(
        maxWidth: maxWidth,
        dynamicHeight: dynamicHeight,
        dynamicWidth: dynamicWidth,
      );
}
