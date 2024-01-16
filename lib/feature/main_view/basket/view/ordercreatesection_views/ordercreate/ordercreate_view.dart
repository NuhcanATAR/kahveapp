import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/model/main_view_model/basket_model/basket_model.dart';
import 'package:kahve/product/utility/base/main_view_base/basket_base/basket_base.dart';
import 'package:kahve/product/utility/database/basket_db/basket_db.dart';
import 'package:kahve/product/utility/service/firebase_service.dart';
import 'package:kahve/product/widget/text_widget/body_medium_text.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class OrderCreateView extends StatefulWidget {
  const OrderCreateView({super.key});

  @override
  State<OrderCreateView> createState() => _OrderCreateViewState();
}

class _OrderCreateViewState extends MainBasketBase<OrderCreateView> {
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
            size: 20,
          ),
        ),
        title: const LabelMediumMainColorText(
          text: "Sipariş Tamamlama",
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: context.padding.normal,
        child: Column(
          children: <Widget>[
            // main body
            buildMainBodyWidget,
            // footer button
            buildFooterButtonWidget,
          ],
        ),
      ),
    );
  }

  // main body
  Widget get buildMainBodyWidget => Expanded(
        child: ListView(
          children: <Widget>[
            // adress select
            buildSelectAdressWidget,
            // payment type select
            buildPaymentTypeSelectWidget,
            // agreement
            buildAgreementWidget,
          ],
        ),
      );

  // select adress
  Widget get buildSelectAdressWidget => Card(
        margin: const EdgeInsets.only(top: 15),
        child: Column(
          children: <Widget>[
            // title
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.7,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: LabelMediumBlackBoldText(
                      text: "Adres Oluştur",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      routerService.adressCreateViewNavigatorRouter(context);
                    },
                    child: const LabelMediumMainColorText(
                      text: "Adres Ekle",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // adress select
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Radio<NullTypes>(
                    activeColor: ColorBackgroundConstant.greenDarker,
                    value: NullTypes.selectType,
                    groupValue: modelService.selectTypes,
                    onChanged: (NullTypes? value) {
                      setState(() {
                        modelService.selectTypes = value;
                      });
                    },
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      child: DropdownButtonFormField<AdressLocations>(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        validator: (value) =>
                            value == null ? "* Zorunlu alan" : null,
                        value: selectTitle,
                        isExpanded: true,
                        hint: Text(
                          "Sipariş Teslim Adresi",
                          style: GoogleFonts.nunito(
                            textStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Colors.black,
                                ),
                          ),
                        ),
                        onChanged: (AdressLocations? categoryMain) {
                          setState(() {
                            selectTitle = categoryMain;
                          });
                        },
                        items: title.map<DropdownMenuItem<AdressLocations>>(
                            (AdressLocations categoryM) {
                          return DropdownMenuItem<AdressLocations>(
                            value: categoryM,
                            child: Text(
                              categoryM.title,
                              style: GoogleFonts.nunito(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  // payment type select
  Widget get buildPaymentTypeSelectWidget => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Column(
          children: <Widget>[
            // title
            SizedBox(
              width: maxWidth,
              child: const LabelMediumBlackBoldText(
                text: "Ödeme Yönteminizi Belirleyin!",
                textAlign: TextAlign.left,
              ),
            ),
            // selects
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  // card payment
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        Radio<PaymentType>(
                          value: PaymentType.cardPay,
                          activeColor: ColorBackgroundConstant.greenDarker,
                          groupValue: modelService.paymentTypes,
                          onChanged: (PaymentType? value) {
                            setState(() {
                              modelService.paymentTypes = value;
                            });
                          },
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: LabelMediumBlackText(
                              text: "Kart ile Ödeme",
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // cash payment
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        Radio<PaymentType>(
                          value: PaymentType.cashPay,
                          activeColor: ColorBackgroundConstant.greenDarker,
                          groupValue: modelService.paymentTypes,
                          onChanged: (PaymentType? value) {
                            setState(() {
                              modelService.paymentTypes = value;
                            });
                          },
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: LabelMediumBlackText(
                              text: "Nakit Ödeme",
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
          ],
        ),
      );

  // agreement
  Widget get buildAgreementWidget => FutureBuilder<DocumentSnapshot>(
        future: BasketDB.AGREEMENT.userAgreementRef,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const SizedBox();
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const SizedBox();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> dataAgreement =
                snapshot.data!.data() as Map<String, dynamic>;
            if (dataAgreement['ACTIVE'] == true) {
              return Column(
                children: <Widget>[
                  // agreement check
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          value: modelService.isAgreementStatus,
                          activeColor: ColorBackgroundConstant.greenDarker,
                          onChanged: (bool? value) {
                            setState(() {
                              modelService.isAgreementStatus = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: LabelMediumBlackText(
                            text:
                                "${dataAgreement['TITLE']} okudum ve kabul ediyorum.",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // agreement card
                  SizedBox(
                    width: maxWidth,
                    height: dynamicHeight(0.4),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.grey.withOpacity(0.6),
                      child: Container(
                        color: Colors.white,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              // title
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: BodyMediumBlackBoldText(
                                  textAlign: TextAlign.center,
                                  text: dataAgreement['TITLE'],
                                ),
                              ),
                              // explanation
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: LabelMediumBlackText(
                                  textAlign: TextAlign.center,
                                  text: dataAgreement['EXPLANATION'],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const SizedBox();
            }
          } else {
            return const SizedBox();
          }
        },
      );
  // footer button
  Widget get buildFooterButtonWidget => SizedBox(
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
                      stream: BasketDB.BASKET.productBasket,
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
                  orderMainInformationSaved();
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
