import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/router/main_view_router/profile_router/profile_router.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class AdressCardWidget extends StatelessWidget with ProfileRouterService {
  const AdressCardWidget(
      {required this.maxWidth,
      required this.dynamicHeight,
      required this.data,
      super.key});

  final dynamic maxWidth;
  final dynamic dynamicHeight;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(
          Icons.circle,
          color: data['ACTIVE'] == true
              ? ColorBackgroundConstant.greenDarker
              : Colors.grey,
          size: 15,
        ),
        title: LabelMediumBlackBoldText(
          text: data['ADRESSTITLE'],
          textAlign: TextAlign.left,
        ),
        subtitle: Column(
          children: <Widget>[
            SizedBox(
              width: maxWidth,
              child: LabelMediumBlackText(
                text: data['ADRESSDESCRIPTION'],
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: maxWidth,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: ColorBackgroundConstant.greenDarker,
                    size: 18,
                  ),
                  LabelMediumBlackText(
                    text: data['CITY'],
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: GestureDetector(
          onTap: () {
            adressEditDeleteShowModelBottomShetDialog(
                context, maxWidth, dynamicHeight, data);
          },
          child: const Icon(
            Icons.more_vert,
            color: Colors.grey,
            size: 18,
          ),
        ),
      ),
    );
  }
}
