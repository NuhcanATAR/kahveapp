import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/constants/img_constants.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class OrderProductCardWidget extends StatelessWidget {
  const OrderProductCardWidget(
      {required this.data,
      required this.maxWidth,
      required this.dynamicHeight,
      required this.routerService,
      super.key});

  final Map<String, dynamic> data;
  final dynamic maxWidth;
  final dynamic dynamicHeight;
  final dynamic routerService;

  @override
  Widget build(BuildContext context) {
    return buildProductCardWidget(context, data);
  }

  // product card widget
  Widget buildProductCardWidget(context, data) => Card(
        child: SizedBox(
          width: maxWidth,
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
                // top: order date, product quanity and total price , order detail button
                buildProductCardTopWidget(context, data),
                // body
                buildProductCardBodyWidget(context, data),
              ],
            ),
          ),
        ),
      );

  // top: order date, product quanity and total price , order detail button
  Widget buildProductCardTopWidget(context, data) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  // order date
                  SizedBox(
                    width: maxWidth,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.date_range_outlined,
                          color: ColorBackgroundConstant.greenDarker,
                          size: 18,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: LabelMediumBlackText(
                              text:
                                  "${data['ORDERDAY']}.${data['ORDERMONTH']}.${data['ORDERYEAR']}",
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // order quanity, total price
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      width: maxWidth,
                      child: LabelMediumBlackText(
                        text:
                            "${data['TOTALQUANITY'].toString()} Adet, Toplam Fiyat ${data['TOTALPRICE'].toString()}₺",
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                routerService.orderDetailViewNavigatorRouter(context, data);
              },
              child: Row(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: LabelMediumMainColorText(
                      textAlign: TextAlign.left,
                      text: "Sipariş Detayı",
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: ColorBackgroundConstant.greenDarker,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  // body
  Widget buildProductCardBodyWidget(context, data) => Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
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
