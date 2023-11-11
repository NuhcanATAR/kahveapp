import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/model/main_view_model/bottommenu_model/bottom_model.dart';

class BottomMenuView extends StatefulWidget {
  const BottomMenuView({super.key});

  @override
  State<BottomMenuView> createState() => _BottomMenuViewState();
}

class _BottomMenuViewState extends State<BottomMenuView> {
  BottomMenuModel serviceModel = BottomMenuModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: serviceModel.mainViewList[serviceModel.selectedViewIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            serviceModel.selectedViewIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: Colors.transparent,
        selectedIndex: serviceModel.selectedViewIndex,
        height: 80,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.favorite,
              color: ColorBackgroundConstant.greenDarker,
              size: 21,
            ),
            icon: const Icon(
              Icons.favorite_outline,
              color: Colors.grey,
              size: 21,
            ),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: ColorBackgroundConstant.greenDarker,
              size: 21,
            ),
            icon: const Icon(
              Icons.home_outlined,
              color: Colors.grey,
              size: 21,
            ),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.account_circle,
              color: ColorBackgroundConstant.greenDarker,
              size: 21,
            ),
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.grey,
              size: 21,
            ),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.shopping_bag,
              color: ColorBackgroundConstant.greenDarker,
              size: 21,
            ),
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.grey,
              size: 21,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
