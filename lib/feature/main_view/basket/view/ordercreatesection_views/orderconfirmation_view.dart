import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/utility/base/main_view_base/basket_base/basket_base.dart';
import 'package:kahve/product/utility/database/basket_db/basket_db.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class OrderConfirmationView extends StatefulWidget {
  const OrderConfirmationView({super.key});

  @override
  State<OrderConfirmationView> createState() => _OrderConfirmationViewState();
}

class _OrderConfirmationViewState
    extends MainBasketBase<OrderConfirmationView> {
  List<DocumentSnapshot> productList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: ColorBackgroundConstant.greenDarker,
              size: 21,
            ),
          ),
          title: const LabelMediumMainColorText(
            text: "Sipariş Kaydet",
            textAlign: TextAlign.center,
          ),
        ),
        body: Column(
          children: <Widget>[
            // main body widget
            buildMainBodyWidget,
            // footer next button
            buildFooterNextButtonWidget,
          ],
        ));
  }

  // main body widget
  Widget get buildMainBodyWidget => Expanded(
        child: ListView(
          children: <Widget>[
            // order product list
            buildOrderProductListWidget,
            // order total price and & total quanity
            buildOrderTotalPriceAndTotalQuanityCardWidget,
            // order delivery adress
            buildOrderDeliveryAdressCardWidget,
          ],
        ),
      );

  // order product list
  Widget get buildOrderProductListWidget => Padding(
        padding: context.padding.low,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: SizedBox(
                width: maxWidth,
                child: const LabelMediumMainColorText(
                  text: "Sipariş Verilecek Ürünler",
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(
              width: maxWidth,
              height: dynamicHeight(0.4),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: StreamBuilder<QuerySnapshot>(
                  stream: BasketDB.BASKET.basketListQuery,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const SizedBox();
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }

                    productList = snapshot.data!.docs;

                    if (snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data!.docs.isNotEmpty) {
                      return ListView(
                        children: productList.map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return ListTile(
                            title: LabelMediumBlackBoldText(
                              text: data['PRODUCTTITLE'],
                              textAlign: TextAlign.left,
                            ),
                            subtitle: LabelMediumGreyText(
                              text: "Fiyat: ${data['PRODUCTPRICE']}₺",
                              textAlign: TextAlign.left,
                            ),
                            trailing: LabelMediumMainColorText(
                              text:
                                  "${data['QUANITY']} Adet / ${data['TOTALPRICE']}₺",
                              textAlign: TextAlign.center,
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );

  // order delivery adress
  Widget get buildOrderDeliveryAdressCardWidget =>
      FutureBuilder<DocumentSnapshot>(
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
                                        text:
                                            "+90 ${data['ADRESSPHONENUMBER']}"),
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

  // order total price and & total quanity
  Widget get buildOrderTotalPriceAndTotalQuanityCardWidget =>
      FutureBuilder<DocumentSnapshot>(
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

  // footer next button
  Widget get buildFooterNextButtonWidget => Padding(
        padding: context.padding.normal,
        child: FutureBuilder<DocumentSnapshot>(
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
              return GestureDetector(
                onTap: () async {
                  orderCreate(data, productList);
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
                      text: "Siparişi Tamamla!",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      );
}
