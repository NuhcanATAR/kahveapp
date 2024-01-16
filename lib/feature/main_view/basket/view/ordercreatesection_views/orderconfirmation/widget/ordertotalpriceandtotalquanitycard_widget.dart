import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/utility/database/basket_db/basket_db.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class OrderTotalPriceAndTotalQuanityCardWidget extends StatelessWidget {
  const OrderTotalPriceAndTotalQuanityCardWidget({
    required this.maxWidth,
    super.key,
  });

  final dynamic maxWidth;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: BasketDB.BASKET.basketMainDocumentsRef,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const SizedBox();
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const SizedBox();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: SizedBox(
                  width: maxWidth,
                  child: const LabelMediumMainColorText(
                    text: "Toplam Ödeme Tutarı",
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      // total quanity
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          width: maxWidth,
                          child: Row(
                            children: <Widget>[
                              const Expanded(
                                child: LabelMediumGreyText(
                                    textAlign: TextAlign.left,
                                    text: "Toplam Adet"),
                              ),
                              LabelMediumBlackBoldText(
                                  textAlign: TextAlign.left,
                                  text:
                                      "( ${data['TOTALQUANITY'].toString()} )"),
                            ],
                          ),
                        ),
                      ),
                      // cargo
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          width: maxWidth,
                          child: const Row(
                            children: <Widget>[
                              Expanded(
                                child: LabelMediumGreyText(
                                    textAlign: TextAlign.left,
                                    text: "Kargo Ücreti"),
                              ),
                              LabelMediumBlackBoldText(
                                  textAlign: TextAlign.left, text: "0₺"),
                            ],
                          ),
                        ),
                      ),
                      // total price
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          width: maxWidth,
                          child: Row(
                            children: <Widget>[
                              const Expanded(
                                child: LabelMediumGreyText(
                                    textAlign: TextAlign.left,
                                    text: "Toplam Fiyat(₺)"),
                              ),
                              LabelMediumBlackBoldText(
                                  textAlign: TextAlign.left,
                                  text: "${data['TOTALPRICE'].toString()}₺"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
