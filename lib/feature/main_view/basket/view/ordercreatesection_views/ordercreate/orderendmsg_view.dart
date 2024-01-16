import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/constants/img_constants.dart';
import 'package:kahve/product/enums/basket_enums.dart';
import 'package:kahve/product/utility/base/main_view_base/basket_base/basket_base.dart';
import 'package:kahve/product/widget/text_widget/body_medium_text.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class OrderEndMsgView extends StatefulWidget {
  const OrderEndMsgView({super.key});

  @override
  State<OrderEndMsgView> createState() => _OrderEndMsgViewState();
}

class _OrderEndMsgViewState extends MainBasketBase<OrderEndMsgView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const LabelMediumMainColorText(
          textAlign: TextAlign.center,
          text: "Sipariş Oluşturuldu!",
        ),
      ),
      body: Padding(
        padding: context.padding.normal,
        child: ListView(
          children: <Widget>[
            // image
            buildImageWidget,
            // title
            buildTitleWidget,
            // description
            buildDescriptionWidget,
            // button
            buildButtonWidget,
          ],
        ),
      ),
    );
  }

  // image
  Widget get buildImageWidget => FadeInDown(
        child: Padding(
          padding: const EdgeInsets.only(left: 55, right: 55),
          child: AppBasketImgConstant.appSuccessfulImg.toImg,
        ),
      );

  // title
  Widget get buildTitleWidget => FadeInDown(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: BodyMediumBlackBoldText(
            text: BasketStrings.orderEndTitleText.value,
            textAlign: TextAlign.center,
          ),
        ),
      );

  // Description
  Widget get buildDescriptionWidget => FadeInDown(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 25),
          child: LabelMediumBlackText(
            text: BasketStrings.orderEndDescriptionText.value,
            textAlign: TextAlign.center,
          ),
        ),
      );

  // button
  Widget get buildButtonWidget => FadeInUp(
        child: GestureDetector(
          onTap: () {
            routerService.homeViewNavigatorRouter(context);
          },
          child: SizedBox(
            width: maxWidth,
            height: dynamicHeight(0.07),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorBackgroundConstant.greenDarker,
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: LabelMediumWhiteText(
                text: BasketStrings.orderButtonText.value,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
}
