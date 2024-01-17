import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/utility/database/order_db/order_db.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class OrderProductListWidget extends StatelessWidget {
  const OrderProductListWidget(
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
    return SizedBox(
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
            // delivered status
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: <Widget>[
                  const LabelMediumGreyBoldText(
                    text: "Tahmini Teslim: ",
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: LabelMediumBlackText(
                        text: data['ORDERTRACKINGSTATUS'].toString(),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // delivered status
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.check,
                    color: data['DELIVERED'] == true
                        ? ColorBackgroundConstant.greenDarker
                        : Colors.grey,
                    size: 18,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: data['DELIVERED'] == true
                          ? const LabelMediumMainColorText(
                              text: "Teslim Edildi",
                              textAlign: TextAlign.left,
                            )
                          : const LabelMediumGreyText(
                              text: "Teslim Edildi",
                              textAlign: TextAlign.left,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            // product list
            StreamBuilder<QuerySnapshot>(
              stream: OrderServiceDB.ORDERPRODUCTS.orderProductsList(data),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const SizedBox();
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }

                return Column(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> dataProduct =
                        document.data()! as Map<String, dynamic>;
                    return Card(
                      child: Row(
                        children: <Widget>[
                          // image
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: FutureBuilder<DocumentSnapshot>(
                              future: OrderServiceDB.PRODUCTS
                                  .productRef(dataProduct),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return const SizedBox();
                                }

                                if (snapshot.hasData &&
                                    !snapshot.data!.exists) {
                                  return const SizedBox();
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  Map<String, dynamic> dataIndex =
                                      snapshot.data!.data()
                                          as Map<String, dynamic>;
                                  return GestureDetector(
                                    onTap: () {
                                      routerService
                                          .productDetailViewNavigatorRouter(
                                              context, dataIndex);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: SizedBox(
                                        width: maxWidth,
                                        height: dynamicHeight(0.13),
                                        child: CachedNetworkImage(
                                          imageUrl: dataProduct['PRODUCTIMG1'],
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(4),
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(4),
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(4),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ),
                          // information
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  // title
                                  SizedBox(
                                    width: maxWidth,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: LabelMediumBlackBoldText(
                                        text: dataProduct['PRODUCTTITLE'],
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),

                                  // sub title
                                  SizedBox(
                                    width: maxWidth,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: LabelMediumBlackText(
                                        text: dataProduct['PRODUCTSUBTITLE'],
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  // coffe size status
                                  dataProduct['PRODUCTCOFFESTATUS'] == true
                                      ? SizedBox(
                                          width: maxWidth,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: LabelMediumBlackText(
                                              text: dataProduct[
                                                          'COFFESMALLSTATUS'] ==
                                                      true
                                                  ? "Küçük Boy"
                                                  : dataProduct[
                                                              'COFFEMEDIUMSTATUS'] ==
                                                          true
                                                      ? "Orta Boy"
                                                      : "Büyük Boy",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                  // quanity & total price
                                  SizedBox(
                                    width: maxWidth,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: LabelMediumMainColorText(
                                        text:
                                            "${dataProduct['QUANITY'].toString()} Adet, Toplam Fiyat: ${dataProduct['TOTALPRICE'].toString()}₺",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
