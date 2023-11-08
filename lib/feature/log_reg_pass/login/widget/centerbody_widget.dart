import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CenterBodyWidget extends StatefulWidget {
  const CenterBodyWidget({
    super.key,
    required this.maxWidth,
    required this.dynamicHeight,
    required this.routerService,
    required this.loginModel,
    required this.loginUser,
  });
  final dynamic maxWidth;
  final dynamic dynamicHeight;
  final dynamic routerService;
  final dynamic loginModel;
  final dynamic loginUser;

  @override
  State<CenterBodyWidget> createState() => _CenterBodyWidgetState();
}

class _CenterBodyWidgetState extends State<CenterBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.loginModel.formLoginKey,
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
                              // email input
                              buildEmailinputWidget(context, context.general),
                              // password input
                              buildPasswordinputWidget(
                                  context, context.general),
                              // remember me
                              buildRememberMeWidget(context, context.general),
                              // login button
                              buildLoginButtonWidget(context),
                              // forgot password button
                              buildForogotPasswordButtonWidget(context),
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

  // remember me
  buildRememberMeWidget(context, contextkartal) => Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            // checkbox widget
            Checkbox(
              activeColor: ColorBackgroundConstant.greenDarker,
              value: widget.loginModel.isRememberChecked,
              onChanged: (bool? value) {
                setState(() {
                  widget.loginModel.isRememberChecked = value!;
                });
                // ignore: avoid_print
                print("Handle Rember Me");
                widget.loginModel.isRememberChecked = value!;
                SharedPreferences.getInstance().then(
                  (prefs) {
                    prefs.setBool("remember_me", value);
                    prefs.setString(
                        'email', widget.loginModel.emailController.text);
                    prefs.setString(
                        'password', widget.loginModel.passwordController.text);
                  },
                );
                setState(() {
                  widget.loginModel.isRememberChecked = value;
                });
              },
            ),
            // text
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: const LabelMediumGreyBoldText(
                  text: "Beni Hatırla",
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      );

  // login button
  Widget buildLoginButtonWidget(context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          onTap: () {
            if (widget.loginModel.formLoginKey.currentState!.validate()) {
              widget.loginUser();
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
                text: "Giriş Yap",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );

  // forgot password button
  Widget buildForogotPasswordButtonWidget(context) => Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 10),
        child: Center(
          child: GestureDetector(
            onTap: () {
              widget.routerService.forgotPasswordNavigatorRouter(context);
            },
            child: const LabelMediumMainColorText(
              text: "Şifremi Unutum!",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}
