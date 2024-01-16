import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/utility/service/firebase_service.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class FooterButtonWidget extends StatelessWidget {
  const FooterButtonWidget(
      {required this.maxWidth,
      required this.dynamicHeight,
      required this.basketQuanityAndTotalPriceControl,
      super.key});

  final dynamic maxWidth;
  final dynamic dynamicHeight;
  final dynamic basketQuanityAndTotalPriceControl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: <Widget>[
            // total quanity
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: LabelMediumGreyText(
                      text: "Toplam Adet",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("BASKET")
                        .doc(FirebaseService().authID)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const SizedBox(); // Hata durumunda boş bir widget dönebilirsiniz
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return const LabelMediumBlackBoldText(
                          textAlign: TextAlign.center,
                          text: "0",
                        );
                      }

                      Map<String, dynamic>? data =
                          snapshot.data!.data() as Map<String, dynamic>?;
                      int totalQuantity = data?['TOTALQUANITY'] ?? 0;

                      return LabelMediumBlackBoldText(
                        textAlign: TextAlign.center,
                        text: "( $totalQuantity )",
                      );
                    },
                  ),
                ],
              ),
            ),
            // total price
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: LabelMediumGreyText(
                      text: "Toplam Fiyat",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("BASKET")
                        .doc(FirebaseService().authID)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const SizedBox(); // Hata durumunda boş bir widget dönebilirsiniz
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return const LabelMediumBlackBoldText(
                          textAlign: TextAlign.center,
                          text: "0",
                        );
                      }

                      Map<String, dynamic>? data =
                          snapshot.data!.data() as Map<String, dynamic>?;
                      num totalQuantity = data?['TOTALPRICE'] ?? 0;

                      return LabelMediumBlackBoldText(
                        textAlign: TextAlign.center,
                        text: "$totalQuantity₺",
                      );
                    },
                  ),
                ],
              ),
            ),
            // next button
            GestureDetector(
              onTap: () {
                basketQuanityAndTotalPriceControl();
              },
              child: SizedBox(
                width: maxWidth,
                height: dynamicHeight(0.08),
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: ColorBackgroundConstant.greenDarker,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: const LabelMediumWhiteText(
                    text: "Devam Et",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
