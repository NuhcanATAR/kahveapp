import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/basket/basket_view.dart';
import 'package:kahve/feature/main_view/favorite/favorite_view.dart';
import 'package:kahve/feature/main_view/home/home_view.dart';
import 'package:kahve/feature/main_view/profile/profile_view.dart';

class BottomMenuModel {
  int selectedViewIndex = 1;

  List<Widget> mainViewList = <Widget>[
    const FavoriteView(),
    const HomeView(),
    const ProfileView(),
    const BasketView(),
  ];
}
