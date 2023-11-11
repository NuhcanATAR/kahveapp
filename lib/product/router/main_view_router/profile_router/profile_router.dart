import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/profile/view/email_upd/emailupd_view.dart';
import 'package:kahve/feature/main_view/profile/view/namesurname_upd/namesurnameupd_view.dart';
import 'package:kahve/feature/main_view/profile/view/orders/orders_view.dart';
import 'package:kahve/feature/main_view/profile/view/savedadress/savedadress_view.dart';

mixin ProfileRouterService {
  void nameSurnameUpdViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NameSurnameUpdView(),
      ),
    );
  }

  void emailUpdViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmailUpdView(),
      ),
    );
  }

  void ordersViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrdersView(),
      ),
    );
  }

  void savedAdresViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SavedAdressView(),
      ),
    );
  }
}
