import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class NoficationsView extends StatefulWidget {
  const NoficationsView({super.key});

  @override
  State<NoficationsView> createState() => _NoficationsViewState();
}

class _NoficationsViewState extends State<NoficationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          text: "Bildirimler",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
