import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/model/log_reg_pas_model/login_model.dart';
import 'package:kahve/product/router/log_reg_pas_router/login_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../product/extension/view_size.dart';

abstract class MainLoginBase<T extends StatefulWidget> extends State<T> {
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
        // ignore: use_build_context_synchronously
        routerService.loginMainBottomMenuViewNavigatorRouter(context);
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
