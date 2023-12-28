import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class ListAdressEmptyView extends StatefulWidget {
  const ListAdressEmptyView({super.key});

  @override
  State<ListAdressEmptyView> createState() => _ListAdressEmptyViewState();
}

class _ListAdressEmptyViewState extends State<ListAdressEmptyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // loading
            buildLoadingWidget,
            // title
            buildTitleWidget,
          ],
        ),
      ),
    );
  }

  // loading
  Widget get buildLoadingWidget => Icon(
        Icons.location_off,
        color: ColorBackgroundConstant.greenDarker,
        size: 65,
      );

  // title
  Widget get buildTitleWidget => const Padding(
        padding: EdgeInsets.all(20),
        child: LabelMediumGreyText(
          text: "Adres Oluşturmadınız, sipariş vermek için adres oluşturun.",
          textAlign: TextAlign.center,
        ),
      );
}
