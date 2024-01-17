import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class OrderPaymentInformationCardWidget extends StatelessWidget {
  const OrderPaymentInformationCardWidget(
      {required this.data, required this.maxWidth, super.key});

  final Map<String, dynamic> data;
  final dynamic maxWidth;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: maxWidth,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.receipt,
                    color: ColorBackgroundConstant.greenDarker,
                    size: 18,
                  ),
                  const Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: LabelMediumMainColorText(
                          text: "Ödeme Bilgileri",
                          textAlign: TextAlign.left,
                        )),
                  ),
                ],
              ),
            ),
            // payment type
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: maxWidth,
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: LabelMediumBlackText(
                        text: "Ödeme Yöntemi",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    LabelMediumBlackText(
                      text: data['PAYMENTTYPE'],
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            // total price
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: maxWidth,
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: LabelMediumBlackText(
                        text: "Ara Toplam",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    LabelMediumBlackText(
                      text: "${data['TOTALPRICE']}₺",
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            // cargo price
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: maxWidth,
                child: const Row(
                  children: <Widget>[
                    Expanded(
                      child: LabelMediumBlackText(
                        text: "Kargo",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    LabelMediumBlackText(
                      text: "0₺",
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            // total
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: maxWidth,
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: LabelMediumBlackText(
                        text: "Ara Toplam",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    LabelMediumMainColorText(
                      text: "${data['TOTALPRICE']}₺",
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
