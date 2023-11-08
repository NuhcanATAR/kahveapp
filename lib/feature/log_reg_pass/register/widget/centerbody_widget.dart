import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kahve/feature/log_reg_pass/register/widget/agrement_checkbox.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class CenterBodyWidget extends StatefulWidget {
  const CenterBodyWidget({
    super.key,
    required this.maxWidth,
    required this.dynamicHeight,
    required this.routerService,
    required this.loginModel,
    required this.userRegister,
  });
  final dynamic maxWidth;
  final dynamic dynamicHeight;
  final dynamic routerService;
  final dynamic loginModel;
  final dynamic userRegister;

  @override
  State<CenterBodyWidget> createState() => _CenterBodyWidgetState();
}

class _CenterBodyWidgetState extends State<CenterBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.loginModel.formRegisterKey,
      child: Center(
        child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: widget.dynamicHeight(0.2),
                  ),
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
                              // name surname
                              buildNameSurnameinputWidget(
                                  context, context.general),
                              // email input
                              buildEmailinputWidget(context, context.general),
                              // password input
                              buildPasswordinputWidget(
                                  context, context.general),
                              // agreement check widget
                              buildAgreementCheckWidget(context),
                              // register button
                              buildRegisterButtonWidget(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  // name surname
  Widget buildNameSurnameinputWidget(context, contextgeneral) => Container(
        margin: const EdgeInsets.only(
          top: 10,
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
              textStyle: contextgeneral.textTheme.labelMedium?.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          controller: widget.loginModel.nameSurnameController,
          validator: widget.loginModel.nameSurnameValidator,
          decoration: InputDecoration(
            icon: const Icon(
              Icons.account_box_outlined,
              color: Colors.black54,
              size: 18,
            ),
            border: InputBorder.none,
            hintText: "Ad Soyad *",
            hintStyle: GoogleFonts.nunito(
              textStyle: GoogleFonts.nunito(
                textStyle: contextgeneral.textTheme.labelMedium?.copyWith(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ),
      );

  // email input
  Widget buildEmailinputWidget(context, contextkartal) => Container(
        margin: const EdgeInsets.only(
          top: 10,
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
          controller: widget.loginModel.emailController,
          validator: widget.loginModel.emailValidator,
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

  // password input
  Widget buildPasswordinputWidget(context, contextkartal) => Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: TextFormField(
          obscureText: widget.loginModel.isPassObscured,
          style: GoogleFonts.nunito(
            textStyle: GoogleFonts.nunito(
              textStyle: contextkartal.textTheme.labelMedium?.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          controller: widget.loginModel.passwordController,
          validator: widget.loginModel.passwordValidator,
          decoration: InputDecoration(
            icon: const Icon(
              Icons.password_outlined,
              color: Colors.black54,
              size: 18,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  widget.loginModel.isPassObscured =
                      !widget.loginModel.isPassObscured;
                });
              },
              icon: Icon(
                widget.loginModel.isPassObscured
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.grey,
                size: 18,
              ),
            ),
            border: InputBorder.none,
            hintText: "Şifre *",
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

  // agreement check widget
  Widget buildAgreementCheckWidget(context) => Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              child: const agrementCheckboxField(),
            ),
          ],
        ),
      );

  // register button
  Widget buildRegisterButtonWidget(context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          onTap: () {
            if (widget.loginModel.formRegisterKey.currentState!.validate()) {
              widget.userRegister();
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
                text: "Kayıt Ol",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
}
