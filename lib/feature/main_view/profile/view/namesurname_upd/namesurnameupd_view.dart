import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class NameSurnameUpdView extends StatelessWidget {
  const NameSurnameUpdView(
      {required this.maxWidth,
      required this.dynamicHeight,
      required this.data,
      required this.nameSurnameUpd,
      super.key});
  final dynamic maxWidth;
  final dynamic dynamicHeight;
  final Map<String, dynamic> data;
  final dynamic nameSurnameUpd;

  @override
  Widget build(BuildContext context) {
    late TextEditingController nameSurnameController = TextEditingController(
      text: data['NAMESURNAME'],
    );
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
            Icons.arrow_back_ios,
            color: ColorBackgroundConstant.greenDarker,
            size: 18,
          ),
        ),
        title: const LabelMediumMainColorText(
          text: "Ad Soyad Güncelle",
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: context.padding.normal,
        child: ListView(
          children: <Widget>[
            // name surname input
            buildNameSurnameinputWidget(
                context, nameSurnameController, context.general),
            // update button
            buildUpdateButtonWidget(nameSurnameController, context),
          ],
        ),
      ),
    );
  }

  // name surname input
  Widget buildNameSurnameinputWidget(
          context, nameSurnameController, contextgeneral) =>
      FadeInUp(
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: TextFormField(
            style: GoogleFonts.nunito(
              textStyle: contextgeneral.textTheme.labelMedium!.copyWith(
                color: Colors.black,
              ),
            ),
            controller: nameSurnameController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              icon: Icon(
                Icons.account_circle_outlined,
                color: Colors.grey,
                size: 18,
              ),
            ),
          ),
        ),
      );

  // update button
  Widget buildUpdateButtonWidget(nameSurnameController, context) => FadeInUp(
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          child: GestureDetector(
            onTap: () async {
              nameSurnameUpd(nameSurnameController, data);
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
                  text: "Güncelle",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      );
}
