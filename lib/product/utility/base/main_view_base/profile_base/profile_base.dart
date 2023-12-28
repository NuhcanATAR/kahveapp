import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/model/main_view_model/profile_model/profile_model.dart';
import 'package:kahve/product/router/main_view_router/profile_router/profile_router.dart';
import 'package:kahve/product/utility/database/profile_db/profile_db.dart';
import 'package:kahve/product/utility/service/firebase_service.dart';
import '../../../../../product/extension/view_size.dart';

abstract class MainProfileBase<T extends StatefulWidget> extends State<T>
    with ProfileRouterService {
  // model service
  ProfileServiceModel modelService = ProfileServiceModel();

  // screens size
  double dynamicWidth(double value) => maxWidth * value;
  double dynamicHeight(double value) => maxHeight * value;

  late final maxWidth = ViewSizeModelExtension(context).mediaSize.width;
  late final maxHeight = ViewSizeModelExtension(context).mediaSize.height;

  // name surname upd
  Future<void> nameSurnameUpd(nameSurnameController, data) async {
    if (nameSurnameController.text == data['NAMESURNAME'].toString()) {
      final snackBar = SnackBar(
        content: const Text("Ad Soyad Aynı saten"),
        action: SnackBarAction(
          label: "Tamam",
          onPressed: () {},
        ),
        duration: const Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      return await FirebaseFirestore.instance
          .collection("USERS")
          .doc(FirebaseService().authID)
          .update({
        "NAMESURNAME": nameSurnameController.text,
      }).then((value) {
        final snackBar = SnackBar(
          content: const Text("Ad Soyad Güncellendi!"),
          action: SnackBarAction(
            label: "Tamam",
            onPressed: () {},
          ),
          duration: const Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }).catchError((err) {
        final snackBar = SnackBar(
          content: const Text("Hata oluştu!, Tekrar Deneyiniz."),
          action: SnackBarAction(
            label: "Tamam",
            onPressed: () {},
          ),
          duration: const Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  // adress create
  Future<void> adressCreate() async {
    return await ProfileDb.ADRESS.userAdressDoc.add({
      "ID": null,
      "ADRESSTITLE": modelService.adressTitleController.text,
      "ADRESSDESCRIPTION": modelService.adressDescriptionController.text,
      "CITY": modelService.selectCityValue.toString(),
      "USERID": FirebaseService().authID,
      "ACTIVE": true,
    }).then((value) {
      String valueDocID = value.id;
      value.update({"ID": valueDocID});
      final snackBar = SnackBar(
        content: const Text("Adres Kaydedildi!"),
        action: SnackBarAction(
          label: "Tamam",
          onPressed: () {},
        ),
        duration: const Duration(
          seconds: 3,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      modelService.adressTitleController.clear();
      modelService.adressDescriptionController.clear();
    }).catchError((err) {
      final snackBar = SnackBar(
        content: const Text("Hata Oluştu, Tekrar Deneyiniz!"),
        action: SnackBarAction(
          label: "Tamam",
          onPressed: () {},
        ),
        duration: const Duration(
          seconds: 3,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      modelService.adressTitleController.clear();
      modelService.adressDescriptionController.clear();
    });
  }

  // adres edit
  Future<void> adressEdit(Map<String, dynamic> data, String adressTitle,
      String adressDescription, String adressCity) async {
    await ProfileDb.ADRESS.userAdressRef(data).update({
      "ADRESSTITLE": adressTitle,
      "ADRESSDESCRIPTION": adressDescription,
      "CITY": adressCity,
    }).then((value) {
      Navigator.pop(context);
      final snackBar = SnackBar(
        content: const Text("Adres Güncellendi!"),
        action: SnackBarAction(
          label: "Tamam",
          onPressed: () {},
        ),
        duration: const Duration(
          seconds: 3,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((err) {
      final snackBar = SnackBar(
        content: const Text("Hata Oluştu, Tekrar Deneyiniz!"),
        action: SnackBarAction(
          label: "Tamam",
          onPressed: () {},
        ),
        duration: const Duration(
          seconds: 3,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(err);
    });
  }
}
