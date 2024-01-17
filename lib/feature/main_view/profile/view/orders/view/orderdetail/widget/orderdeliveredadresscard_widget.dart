import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class OrderDeliveredAdressCardWidget extends StatelessWidget {
  const OrderDeliveredAdressCardWidget(
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
                    Icons.location_on,
                    color: ColorBackgroundConstant.greenDarker,
                    size: 18,
                  ),
                  const Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: LabelMediumMainColorText(
                          text: "Teslimat Adresi",
                          textAlign: TextAlign.left,
                        )),
                  ),
                ],
              ),
            ),
            // user name surname
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: maxWidth,
                child: LabelMediumBlackText(
                  text:
                      "Alıcı: ${data['ADRESSUSERNAME']} ${data['ADRESSUSERSURNAME']}",
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            // adress
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: maxWidth,
                child: LabelMediumBlackText(
                  text: "${data['ADRESSDESCRIPTION']}",
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            // city and district
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: maxWidth,
                child: LabelMediumBlackText(
                  text: "${data['ADRESSCITY']}",
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            // phone number
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: maxWidth,
                child: LabelMediumBlackText(
                  text: "${data['ADRESSUSERPHONENUMBER']}",
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
