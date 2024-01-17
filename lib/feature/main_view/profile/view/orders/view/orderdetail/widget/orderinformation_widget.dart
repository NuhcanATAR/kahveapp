import 'package:flutter/material.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class OrderInformationCardWidget extends StatelessWidget {
  const OrderInformationCardWidget({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: Column(
          children: <Widget>[
            // order ıd
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: <Widget>[
                  const LabelMediumGreyBoldText(
                    text: "Sipariş Numarası: ",
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: LabelMediumBlackText(
                        text: data['ORDERID'].toString(),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // date
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: <Widget>[
                  const LabelMediumGreyBoldText(
                    text: "Sipariş Tarihi: ",
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: LabelMediumBlackText(
                        text:
                            "${data['ORDERDAY'].toString()}.${data['ORDERMONTH'].toString()}.${data['ORDERYEAR'].toString()}",
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // order quanity
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: <Widget>[
                  const LabelMediumGreyBoldText(
                    text: "Sipariş Özeti: ",
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: LabelMediumBlackText(
                        text: data['DELIVERED'] == true
                            ? "${data['TOTALQUANITY'].toString()} Ürün, ${data['TOTALQUANITY'].toString()} Teslim Edildi"
                            : "${data['TOTALQUANITY'].toString()} Ürün, ${data['TOTALQUANITY'].toString()} Teslim Edilecek",
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // order total price
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: <Widget>[
                  const LabelMediumGreyBoldText(
                    text: "Sipariş Toplam Fiyat: ",
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: LabelMediumBlackText(
                        text: "${data['TOTALPRICE'].toString()}₺",
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
