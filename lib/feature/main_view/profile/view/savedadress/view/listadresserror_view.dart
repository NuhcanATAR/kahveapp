import 'package:flutter/material.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class ListAdressErrorView extends StatefulWidget {
  const ListAdressErrorView({super.key});

  @override
  State<ListAdressErrorView> createState() => _ListAdressErrorViewState();
}

class _ListAdressErrorViewState extends State<ListAdressErrorView> {
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
  Widget get buildLoadingWidget => const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 45,
      );

  // title
  Widget get buildTitleWidget => const Padding(
        padding: EdgeInsets.all(20),
        child: LabelMediumGreyText(
          text: "Hata Oluştu Tekrar Deneyiniz",
          textAlign: TextAlign.center,
        ),
      );
}
