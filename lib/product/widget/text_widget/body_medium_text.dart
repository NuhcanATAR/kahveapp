import 'package:flutter/material.dart';

// pub dev
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';

class BodyMediumBlackGreyText extends StatelessWidget {
  const BodyMediumBlackGreyText(
      {required this.textAlign, required this.text, super.key});
  final String text;
  final dynamic textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.nunito(
        textStyle: context.general.textTheme.bodyMedium?.copyWith(
          color: Colors.black54,
        ),
      ),
    );
  }
}

class BodyMediumBlackBoldText extends StatelessWidget {
  const BodyMediumBlackBoldText(
      {required this.textAlign, required this.text, super.key});
  final String text;
  final dynamic textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.nunito(
        textStyle: context.general.textTheme.bodyMedium?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
