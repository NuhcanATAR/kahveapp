import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/utility/database/basket_db/basket_db.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class OrderDeliveryAdressCardWidget extends StatelessWidget {
  const OrderDeliveryAdressCardWidget({
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
                    text: "Sipariş Teslim Adresi",
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
                      // title
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          width: maxWidth,
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.location_city,
                                color: Colors.grey,
                                size: 18,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: LabelMediumBlackBoldText(
                                      textAlign: TextAlign.left,
                                      text: data['ADRESSTITLE']),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // user name
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          width: maxWidth,
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.account_circle_outlined,
                                color: Colors.grey,
                                size: 18,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: LabelMediumBlackText(
                                      textAlign: TextAlign.left,
                                      text:
                                          "${data['ADRESSUSERNAME']} ${data['ADRESSSURNAME']}"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // user phone number
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          width: maxWidth,
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.call,
                                color: Colors.grey,
                                size: 18,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: LabelMediumBlackText(
                                      textAlign: TextAlign.left,
                                      text: "+90 ${data['ADRESSPHONENUMBER']}"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // location
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          width: maxWidth,
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.location_on,
                                color: Colors.grey,
                                size: 18,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: LabelMediumBlackText(
                                      textAlign: TextAlign.left,
                                      text: "${data['ADRESSCITY']}"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // description
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          width: maxWidth,
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.home_outlined,
                                color: Colors.grey,
                                size: 18,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: LabelMediumBlackText(
                                      textAlign: TextAlign.left,
                                      text: data['ADRESSDESCRIPTION']),
                                ),
                              ),
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
