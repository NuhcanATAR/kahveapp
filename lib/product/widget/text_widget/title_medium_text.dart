import 'package:flutter/material.dart';

// pub dev
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';

class TitleMediumBlackBoldText extends StatelessWidget {
  const TitleMediumBlackBoldText(
      {required this.textAlign, required this.text, super.key});

  final String text;
  final dynamic textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.nunito(
        textStyle: context.general.textTheme.titleMedium?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TitleMediumBlackGreyBoldText extends StatelessWidget {
  const TitleMediumBlackGreyBoldText(
      {required this.textAlign, required this.text, super.key});

  final String text;
  final dynamic textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.nunito(
        textStyle: context.general.textTheme.titleMedium?.copyWith(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TitleMediumWhiteText extends StatelessWidget {
  const TitleMediumWhiteText(
      {required this.textAlign, required this.text, super.key});

  final String text;
  final dynamic textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.nunito(
        textStyle: context.general.textTheme.titleMedium?.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

class TitleMediumWhiteBoldText extends StatelessWidget {
  const TitleMediumWhiteBoldText(
      {required this.textAlign, required this.text, super.key});

  final String text;
  final dynamic textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.nunito(
        textStyle: context.general.textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
