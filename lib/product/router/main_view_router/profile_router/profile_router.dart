// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kahve/feature/log_reg_pass/login/login_view.dart';
import 'package:kahve/feature/main_view/profile/view/email_upd/emailupd_view.dart';
import 'package:kahve/feature/main_view/profile/view/namesurname_upd/namesurnameupd_view.dart';
import 'package:kahve/feature/main_view/profile/view/orders/orders_view.dart';
import 'package:kahve/feature/main_view/profile/view/savedadress/savedadress_view.dart';
import 'package:kahve/feature/main_view/profile/view/savedadress/view/createadress.dart';
import 'package:kahve/feature/main_view/profile/view/savedadress/view/updateadress.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/utility/database/profile_db/profile_db.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin ProfileRouterService {
  void nameSurnameUpdViewNavigatorRouter(
      BuildContext context, data, maxWidth, dynamicHeight, nameSurnameUpd) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NameSurnameUpdView(
          data: data,
          maxWidth: maxWidth,
          dynamicHeight: dynamicHeight,
          nameSurnameUpd: nameSurnameUpd,
        ),
      ),
    );
  }

  void emailUpdViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmailUpdView(),
      ),
    );
  }

  void ordersViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrdersView(),
      ),
    );
  }

  void savedAdresViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SavedAdressView(),
      ),
    );
  }

  void createAdressViewNavigatorRouter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateAdressView(),
      ),
    );
  }

  void accountExitDialog(BuildContext context) {
    var alertDialog = AlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(5),
        child: LabelMediumBlackBoldText(
          text: "Çıkış Yapmak İstediğinize Eminmisiniz?",
          textAlign: TextAlign.center,
        ),
      ),
      content: const Padding(
        padding: EdgeInsets.all(5),
        child: LabelMediumGreyText(
          text:
              "Çıkış yaptığınız zaman oturumunuz kapatılır ve tekrar giriş yapmak zorunda kalırsınız!",
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool("remember_me", false);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginView(),
                ),
                (Route<dynamic> route) => false);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorBackgroundConstant.greenDarker,
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: const LabelMediumWhiteText(
              text: "Evet Çıkış Yap",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: const LabelMediumWhiteText(
              text: "Hayır",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  void adressEditDeleteShowModelBottomShetDialog(BuildContext context,
      dynamic maxWidth, dynamic dynamicHeight, Map<String, dynamic> data) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => SizedBox(
        width: maxWidth,
        height: dynamicHeight(0.15),
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // delete
                GestureDetector(
                  onTap: () async {
                    await ProfileDb.ADRESS
                        .userAdressRef(data)
                        .delete()
                        .then((value) {
                      final snackBar = SnackBar(
                        content: const Text("Adres Başarıyla Silindi!"),
                        action: SnackBarAction(
                          label: "Tamam",
                          onPressed: () {},
                        ),
                        duration: const Duration(seconds: 4),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                    }).catchError((err) {
                      final snackBar = SnackBar(
                        content: const Text("Hata Oluştu, Tekrar Deneyiniz!"),
                        action: SnackBarAction(
                          label: "Tamam",
                          onPressed: () {},
                        ),
                        duration: const Duration(seconds: 4),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: LabelMediumBlackText(
                            text: "Adresi Sil",
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
                // edit
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    adressEditNavigatorRouterView(context, data);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: <Widget>[
                        const Expanded(
                          child: LabelMediumBlackText(
                            text: "Adresi Düzenle",
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Icon(
                          Icons.edit,
                          color: ColorBackgroundConstant.greenDarker,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void adressEditNavigatorRouterView(
      BuildContext context, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateAdressView(
          data: data,
        ),
      ),
    );
  }
}
