import 'package:flutter/material.dart';

// pub dev
import 'package:google_fonts/google_fonts.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kartal/kartal.dart';

class LabelMediumGreyText extends StatelessWidget {
  const LabelMediumGreyText(
      {required this.textAlign, required this.text, super.key});

  final String text;
  final dynamic textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.nunito(
        textStyle: context.general.textTheme.labelMedium?.copyWith(
          color: Colors.grey,
        ),
      ),
    );
  }
}

class LabelMediumWhiteText extends StatelessWidget {
  const LabelMediumWhiteText(
      {required this.textAlign, required this.text, super.key});

  final String text;
  final dynamic textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.nunito(
        textStyle: context.general.textTheme.labelMedium?.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

class LabelMediumGreyBoldText extends StatelessWidget {
  const LabelMediumGreyBoldText(
      {required this.textAlign, required this.text, super.key});

  final String text;
  final dynamic textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.nunito(
        textStyle: context.general.textTheme.labelMedium?.copyWith(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class LabelMediumBlackBoldText extends StatelessWidget {
  const LabelMediumBlackBoldText(
      {required this.textAlign, required this.text, super.key});

  final String text;
  final dynamic textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.nunito(
        textStyle: context.general.textTheme.labelMedium?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class LabelMediumMainColorText extends StatelessWidget {
  const LabelMediumMainColorText(
      {required this.textAlign, required this.text, super.key});

  final String text;
  final dynamic textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.nunito(
        textStyle: context.general.textTheme.labelMedium?.copyWith(
          color: ColorTextConstants.textgreenDarker,
        ),
      ),
    );
  }
}

class LabelMediumRedColorText extends StatelessWidget {
  const LabelMediumRedColorText(
      {required this.textAlign, required this.text, super.key});

  final String text;
  final dynamic textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.nunito(
        textStyle: context.general.textTheme.labelMedium?.copyWith(
          color: Colors.red,
        ),
      ),
    );
  }
}
