import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/widget/text_widget/body_medium_text.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class CenterBodyWidget extends StatelessWidget {
  const CenterBodyWidget({
    super.key,
    required this.maxWidth,
    required this.dynamicHeight,
    required this.routerService,
  });
  final dynamic maxWidth;
  final dynamic dynamicHeight;
  final dynamic routerService;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: dynamicHeight(0.1),
              ),
              FadeInUp(
                child: Card(
                  child: SizedBox(
                    width: maxWidth,
                    child: Container(
                      padding: context.padding.normal,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          // title & sub title
                          buildTitleSubTitleWidget,
                          // login button
                          buildLoginButtonWidget(context),
                          // register button
                          buildRegisterButtonWidget(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  // title & sub title
  Widget get buildTitleSubTitleWidget => const Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 5, top: 10),
            child: BodyMediumBlackBoldText(
              text: "Kahve Uygulamasına Hoşgeldiniz.",
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: LabelMediumGreyText(
              text:
                  "Kahve Dünyasına giriş yaparak size uygun kahveyi sipariş verin.",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );

  // login button
  Widget buildLoginButtonWidget(context) => Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 10),
        child: GestureDetector(
          onTap: () {
            routerService.logregLoginRouterNavigator(context);
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
              child: const LabelMediumWhiteText(
                text: "Giriş Yap",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );

  // register button
  Widget buildRegisterButtonWidget(context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          onTap: () {
            routerService.logregRegisterRouterNavigator(context);
          },
          child: SizedBox(
            width: maxWidth,
            height: dynamicHeight(0.07),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: ColorBackgroundConstant.greenDarker,
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: const LabelMediumMainColorText(
                text: "Kayıt Ol",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
}
