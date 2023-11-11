import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/profile/widget/menus_widget.dart';
import 'package:kahve/feature/main_view/profile/widget/profiletopcard_widget.dart';
import 'package:kahve/product/utility/base/main_view_base/profile_base/profile_base.dart';
import 'package:kahve/product/utility/database/profile_db/profile_db.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends MainProfileBase<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const LabelMediumMainColorText(
          text: "Profile Sayfası",
          textAlign: TextAlign.center,
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: ProfileDb.USERS.userRef,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const SizedBox();
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const SizedBox();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: context.padding.normal,
              child: ListView(
                children: <Widget>[
                  // profile top card
                  buildProfileTopCardWidget(data, context),
                  // menus
                  buildMenusWidget(data, context),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  // profile top card
  Widget buildProfileTopCardWidget(data, context) => ProfileTopCard(
        data: data,
        maxWidth: maxWidth,
        dynamicWidth: dynamicWidth,
        dynamicHeight: dynamicHeight,
      );

  // menus
  Widget buildMenusWidget(data, context) => MenusWidget(
        data: data,
        maxWidth: maxWidth,
        dynamicWidth: dynamicWidth,
        dynamicHeight: dynamicHeight,
        nameSurnameUpdViewRouter: nameSurnameUpdViewNavigatorRouter,
        emailUpdViewRouter: emailUpdViewNavigatorRouter,
        ordersViewRouter: ordersViewNavigatorRouter,
        savedAdressViewRouter: savedAdresViewNavigatorRouter,
      );
}
