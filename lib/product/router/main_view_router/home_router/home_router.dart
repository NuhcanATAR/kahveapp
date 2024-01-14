import 'package:flutter/material.dart';

import 'package:kahve/feature/main_view/home/view/blogdetail/blogdetail_view.dart';
import 'package:kahve/feature/main_view/home/view/category/maincategorylist_view.dart';
import 'package:kahve/feature/main_view/home/view/category/subcategorylist_view.dart';
import 'package:kahve/feature/main_view/home/view/nofications/nofications_view.dart';
import 'package:kahve/feature/main_view/home/view/productdetail/productdetail_view.dart';
import 'package:kahve/feature/main_view/home/view/productlist/productlist_view.dart';
import 'package:kahve/feature/main_view/home/view/search/search_view.dart';
import 'package:kahve/feature/main_view/profile/profile_view.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeRouterService {
  // profile view router
  void profileViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileView(),
      ),
    );
  }

  // nofication view router
  void noficationViewNavigator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NoficationsView(),
      ),
    );
  }

  // search view router
  void searchViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchView(),
      ),
    );
  }

  // main category list view router
  void mainCategoryViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainCategoryListView(),
      ),
    );
  }

  // sub category list view router
  void subCategoryListViewNavigatorRouter(
      BuildContext context, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubCategoryListView(data: data),
      ),
    );
  }

  // web page router
  void webPageViewNavigatorRouter(
      BuildContext context, Map<String, dynamic> data) async {
    if (!await launchUrl(Uri.parse(data['URL'].toString()))) {
      throw Exception('Url Bulunamadı!');
    }
  }

  // product detail view router
  void productDetailViewNavigatorRouter(
      BuildContext context, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailView(
          data: data,
        ),
      ),
    );
  }

  // blog detail view router
  void blogDetailViewNavigatorRouter(
      BuildContext context, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlogDetailView(
          data: data,
        ),
      ),
    );
  }

  // product list view router
  void productListViewNavigatorRouter(
      BuildContext context, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductListView(data: data),
      ),
    );
  }
}
