import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/constants/img_constants.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class OrderStatusBarWidget extends StatelessWidget {
  const OrderStatusBarWidget(
      {required this.data,
      required this.maxWidth,
      required this.dynamicHeight,
      super.key});

  final Map<String, dynamic> data;
  final dynamic maxWidth;
  final dynamic dynamicHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: data['ORDERREJECT'] == false
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // order accept status
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: data['ORDERSTATUS'] == true
                                ? ColorBackgroundConstant.greenDarker
                                : Colors.grey,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(124),
                            ),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: data['ORDERSTATUS'] == true
                            ? const LabelMediumMainColorText(
                                textAlign: TextAlign.center,
                                text: "Sipariş Alındı")
                            : const LabelMediumGreyText(
                                textAlign: TextAlign.center,
                                text: "Sipariş Alındı"),
                      ),
                    ],
                  ),
                ),
                // order in progress
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: data['ORDERINPROGRESSSTATUS'] == true
                                ? ColorBackgroundConstant.greenDarker
                                : Colors.grey,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(124),
                            ),
                          ),
                          child: AppOrderImgConstant.appOrderInProgress.toImg,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: data['ORDERINPROGRESSSTATUS'] == true
                            ? const LabelMediumMainColorText(
                                textAlign: TextAlign.center,
                                text: "Sipariş Hazırlanıyor")
                            : const LabelMediumGreyText(
                                textAlign: TextAlign.center,
                                text: "Sipariş Hazırlanıyor"),
                      ),
                    ],
                  ),
                ),
                // shipped
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: data['CARGOSTATUS'] == true
                                ? ColorBackgroundConstant.greenDarker
                                : Colors.grey,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(124),
                            ),
                          ),
                          child: AppOrderImgConstant.appOrderCourier.toImg,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: data['CARGOSTATUS'] == true
                            ? const LabelMediumMainColorText(
                                textAlign: TextAlign.center,
                                text: "Kargoya Verildi")
                            : const LabelMediumGreyText(
                                textAlign: TextAlign.center,
                                text: "Kargoya Verildi"),
                      ),
                    ],
                  ),
                ),
                // delivered
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: data['DELIVERED'] == true
                                ? ColorBackgroundConstant.greenDarker
                                : Colors.grey,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(124),
                            ),
                          ),
                          child: AppOrderImgConstant.appOrderDelivered.toImg,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: data['DELIVERED'] == true
                            ? const LabelMediumMainColorText(
                                textAlign: TextAlign.center,
                                text: "Teslim Edildi")
                            : const LabelMediumGreyText(
                                textAlign: TextAlign.center,
                                text: "Teslim Edildi"),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : SizedBox(
              width: maxWidth,
              height: dynamicHeight(0.07),
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.warning_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: LabelMediumWhiteText(
                        text: "Siparişiniz İptal Edilmiştir!",
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
