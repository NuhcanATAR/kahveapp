import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/utility/base/main_view_base/basket_base/basket_base.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OrderEndLoadingView extends StatefulWidget {
  const OrderEndLoadingView({super.key});

  @override
  State<OrderEndLoadingView> createState() => _OrderEndLoadingViewState();
}

class _OrderEndLoadingViewState extends MainBasketBase<OrderEndLoadingView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(
          seconds: 6,
        ), () {
      routerService.orderEndMsgViewNavigatorRouter(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // loading
            LoadingAnimationWidget.hexagonDots(
              color: ColorBackgroundConstant.greenDarker,
              size: 45,
            ),
            // title
            const Padding(
                padding:
                    EdgeInsets.only(top: 40, bottom: 10, left: 10, right: 10),
                child: LabelMediumBlackBoldText(
                  textAlign: TextAlign.center,
                  text: "Siparişiniz Oluşturuluyor",
                )),
            // sub title
            const Padding(
                padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: LabelMediumGreyText(
                  textAlign: TextAlign.center,
                  text: "Lütfen Bekleyiniz...",
                )),
          ],
        ),
      ),
    );
  }
}
