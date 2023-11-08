// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/mixin/login_mixin.dart';
import 'package:kahve/product/model/log_reg_pas_model/login_model.dart';
import 'package:kahve/product/router/log_reg_pas_router/login_router.dart';
import 'package:kartal/kartal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../product/extension/view_size.dart';

abstract class MainLoginBase<T extends StatefulWidget> extends State<T>
    with loginMixin {
  // router service
  LoginViewRouterService routerService = LoginViewRouterService();

  // model service
  LoginViewModelService modelService = LoginViewModelService();

  // screens size
  double dynamicWidth(double value) => maxWidth * value;
  double dynamicHeight(double value) => maxHeight * value;

  late final maxWidth = ViewSizeModelExtension(context).mediaSize.width;
  late final maxHeight = ViewSizeModelExtension(context).mediaSize.height;

  @override
  void initState() {
    super.initState();

    getConnnectivityStatus();
    _loadUserEmailPassword();
  }

  // login
  Future<void> loginUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: modelService.emailController.text.toString(),
        password: modelService.passwordController.text.toString(),
      );

      User? user = userCredential.user;

      if (!user!.emailVerified) {
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'E-postanızı doğurlamadan giriş yapamazsınız!',
        );
      }
      routerService.loginMainBottomMenuViewNavigatorRouter(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        userNotFound(context, context.general);
      } else if (e.code == 'wrong-password') {
        wrongPassword(context, context.general);
      } else if (e.code == 'too-many-requests') {
        tooManyRequest(context, context.general);
      } else if (e.code == 'email-not-verified') {
        requiresrecentlogin(context, context.general);
      }
    } catch (e) {
      modelService.logger.i(e);
    }
  }

  // connectivity status
  getConnnectivityStatus() => modelService.subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        modelService.isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
        if (!modelService.isDeviceConnected &&
            modelService.isAlertDialog == false) {
          showDialogBox();
          setState(() {
            modelService.isAlertDialog = true;
          });
        }
      });

  showDialogBox() => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Icon(
            Icons.wifi_off_rounded,
            color: Colors.redAccent,
            size: 55,
          ),
          content: Text(
            'İnternet bağlantınız yok! Lütfen tekrar deneyiniz.',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'Cancel');
                  setState(() => modelService.isAlertDialog = false);
                  modelService.isDeviceConnected =
                      await InternetConnectionChecker().hasConnection;
                  if (!modelService.isDeviceConnected &&
                      modelService.isAlertDialog == false) {
                    showDialogBox();
                    setState(() => modelService.isAlertDialog = true);
                  }
                },
                child: Text(
                  'Tekrar Dene',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorBackgroundConstant.greenDarker,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );

  // ignore: unused_element
  void _loadUserEmailPassword() async {
    // ignore: avoid_print
    print("Load Email");
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      // ignore: no_leading_underscores_for_local_identifiers
      var _email = _prefs.getString("email") ?? "";
      // ignore: no_leading_underscores_for_local_identifiers
      var _password = _prefs.getString("password") ?? "";
      // ignore: no_leading_underscores_for_local_identifiers
      var _remeberMe = _prefs.getBool("remember_me") ?? false;

      // ignore: avoid_print
      print(_remeberMe);
      // ignore: avoid_print
      print(_email);
      // ignore: avoid_print
      print(_password);
      if (_remeberMe) {
        setState(() {
          modelService.isRememberChecked = true;
        });
        modelService.emailController.text = _email;
        modelService.passwordController.text = _password;

        FirebaseAuth auth = FirebaseAuth.instance;
        User? user = auth.currentUser;

        if (user != null) {
          if (user.emailVerified) {
            String uid = user.uid;
            modelService.logger.i("Kullanıcı UID: $uid");

            routerService.loginMainBottomMenuViewNavigatorRouter(context);
          } else {
            final snackBar = SnackBar(
              content: const Text('E-mail Adresinizi Doğrulayınız!'),
              action: SnackBarAction(
                label: 'Tamam',
                onPressed: () {},
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } else {
          modelService.logger.i("Mevcut oturumda kullanıcı yok.");
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // connection controller
  @override
  void dispose() {
    modelService.subscription.cancel();
    super.dispose();
  }
}
