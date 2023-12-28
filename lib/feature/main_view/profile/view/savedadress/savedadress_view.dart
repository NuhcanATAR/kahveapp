import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/profile/view/savedadress/view/listadressempty_view.dart';
import 'package:kahve/feature/main_view/profile/view/savedadress/view/listadresserror_view.dart';
import 'package:kahve/feature/main_view/profile/view/savedadress/view/listadressloading_view.dart';
import 'package:kahve/feature/main_view/profile/view/savedadress/widget/adresscard_widget.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/utility/base/main_view_base/profile_base/profile_base.dart';
import 'package:kahve/product/utility/database/profile_db/profile_db.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class SavedAdressView extends StatefulWidget {
  const SavedAdressView({super.key});

  @override
  State<SavedAdressView> createState() => _SavedAdressViewState();
}

class _SavedAdressViewState extends MainProfileBase<SavedAdressView> {
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
          text: "Kayıtlı Adresler",
          textAlign: TextAlign.center,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                createAdressViewNavigatorRouter(context);
              },
              child: Icon(
                Icons.add,
                color: ColorBackgroundConstant.greenDarker,
                size: 20,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: context.padding.normal,
        child: StreamBuilder<QuerySnapshot>(
          stream: ProfileDb.ADRESS.userAdressListQuery,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return adressErrorViewWidget;
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildAdressLoadingViewWidget;
            }

            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.docs.isNotEmpty) {
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return buildAdressCardWidget(data);
                }).toList(),
              );
            } else {
              return buildAdressListEmptyViewWidget;
            }
          },
        ),
      ),
    );
  }

  // adress error wiew widget
  Widget get adressErrorViewWidget => const ListAdressErrorView();

  // adress locading view widget
  Widget get buildAdressLoadingViewWidget => const ListAdressLoadingView();

  // adress card widget
  Widget buildAdressCardWidget(Map<String, dynamic> data) => AdressCardWidget(
        maxWidth: maxWidth,
        dynamicHeight: dynamicHeight,
        data: data,
      );

  // adress list empty view widget
  Widget get buildAdressListEmptyViewWidget => const ListAdressEmptyView();
}
