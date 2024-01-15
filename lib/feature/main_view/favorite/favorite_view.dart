import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/favorite/view/error_view.dart';
import 'package:kahve/feature/main_view/favorite/view/loading_view.dart';
import 'package:kahve/feature/main_view/favorite/view/noproduct_view.dart';
import 'package:kahve/feature/main_view/home/view/search/widget/productcard_widget.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/enums/favorite_enums.dart';
import 'package:kahve/product/utility/base/main_view_base/favorite_base/favorite_base.dart';
import 'package:kahve/product/utility/database/favorite_db/favorite_db.dart';
import 'package:kahve/product/utility/service/firebase_service.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends MainFavoriteBase<FavoriteView> {
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
          text: "Favori Ürünlerim",
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FavoriteServiceDB.FAVORITE.favoriteListQuery,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return ErrorView(
                title: FavoriteStrings.errorTitleText.value,
                subTitle: FavoriteStrings.errorSubTitleText.value,
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingView(
                title: FavoriteStrings.loadingTitleText.value,
                subTitle: FavoriteStrings.loadingSubTitleText.value,
              );
            }

            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.docs.isNotEmpty) {
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  if (data['USERID'] == FirebaseService().authID) {
                    return FutureBuilder<DocumentSnapshot>(
                      future: FavoriteServiceDB.PRODUCTS.productRef(data),
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
                          return ProductCardWidget(
                            data: dataProduct,
                            routerService: routerService,
                            maxWidth: maxWidth,
                            dynamicHeight: dynamicHeight,
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                }).toList(),
              );
            } else {
              return NoProductView(
                title: FavoriteStrings.noTitleText.value,
                subTitle: FavoriteStrings.noSubTitleText.value,
              );
            }
          },
        ),
      ),
    );
  }
}
