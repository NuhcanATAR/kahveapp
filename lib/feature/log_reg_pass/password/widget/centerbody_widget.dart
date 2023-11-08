import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class CenterBodyWidget extends StatefulWidget {
  const CenterBodyWidget({
    super.key,
    required this.maxWidth,
    required this.dynamicHeight,
    required this.routerService,
    required this.passwordModel,
    required this.resetPasswordBase,
  });
  final dynamic maxWidth;
  final dynamic dynamicHeight;
  final dynamic routerService;
  final dynamic passwordModel;
  final dynamic resetPasswordBase;

  @override
  State<CenterBodyWidget> createState() => _CenterBodyWidgetState();
}

class _CenterBodyWidgetState extends State<CenterBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.passwordModel.formResPasswordKey,
      child: Center(
        child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FadeInUp(
                  child: Card(
                    child: SizedBox(
                      width: widget.maxWidth,
                      child: Container(
                        padding: context.padding.normal,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            // email input
                            buildEmailinputWidget(context, context.general),
                            // password reset button
                            buildResPasswordButtonWidget(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  // email inputt
  Widget buildEmailinputWidget(context, contextkartal) => Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: TextFormField(
          style: GoogleFonts.nunito(
            textStyle: GoogleFonts.nunito(
              textStyle: contextkartal.textTheme.labelMedium?.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          controller: widget.passwordModel.emailController,
          validator: widget.passwordModel.emailValidator,
          decoration: InputDecoration(
            icon: const Icon(
              Icons.email_outlined,
              color: Colors.black54,
              size: 18,
            ),
            border: InputBorder.none,
            hintText: "Email *",
            hintStyle: GoogleFonts.nunito(
              textStyle: GoogleFonts.nunito(
                textStyle: contextkartal.textTheme.labelMedium?.copyWith(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ),
      );

  // password reset button
  Widget buildResPasswordButtonWidget(context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          onTap: () {
            if (widget.passwordModel.formResPasswordKey.currentState!
                .validate()) {
              widget.resetPasswordBase();
            }
          },
          child: SizedBox(
            width: widget.maxWidth,
            height: widget.dynamicHeight(0.07),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorBackgroundConstant.greenDarker,
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: const LabelMediumWhiteText(
                text: "Doğrula",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
}
