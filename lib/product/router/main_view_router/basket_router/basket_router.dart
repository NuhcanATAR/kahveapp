import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/basket/view/ordercreatesection_views/orderconfirmation_view.dart';
import 'package:kahve/feature/main_view/basket/view/ordercreatesection_views/ordercreate_view.dart';
import 'package:kahve/feature/main_view/basket/view/ordercreatesection_views/orderendloading_view.dart';
import 'package:kahve/feature/main_view/basket/view/ordercreatesection_views/orderendmsg_view.dart';
import 'package:kahve/feature/main_view/bottommenu_view/bottommenu_view.dart';
import 'package:kahve/feature/main_view/home/view/productdetail/productdetail_view.dart';
import 'package:kahve/feature/main_view/profile/view/savedadress/view/createadress.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class BasketRouterService {
  // home view router
  void homeViewNavigatorRouter(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomMenuView(),
        ),
        (Route<dynamic> route) => false);
  }

  // order end msg loading
  void orderEndMsgViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderEndMsgView(),
      ),
    );
  }

  // order end loading view
  void orderEndLoadingViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderEndLoadingView(),
      ),
    );
  }

  // order confirmation view
  void orderConfirmationViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderConfirmationView(),
      ),
    );
  }

  // product detail view
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

  // adress create view
  void adressCreateViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateAdressView(),
      ),
    );
  }

  // payment type select router
  void paymentTypeSelectViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          var curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return const OrderCreateView();
        },
      ),
    );
  }
}

mixin BasketMixinVoid {
  void alertBasketProductRemoveDialog(
      context, dynamic basketSelectProductDelete, data) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.23,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.grey.withOpacity(0.3),
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 10, right: 10),
                alignment: Alignment.centerLeft,
                child: const LabelMediumBlackText(
                  text:
                      "Ürünü Sepetinizden kaldırmak istediğinize eminmisiniz?",
                  textAlign: TextAlign.left,
                ),
              ),
              GestureDetector(
                onTap: () {
                  basketSelectProductDelete(data);
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.delete,
                        color: Colors.black54,
                        size: 24,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: LabelMediumBlackText(
                            text: "Ürünü Kaldır",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                )),
                child: const LabelMediumBlackText(
                  text: "Vazgeç",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
