// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/noconnection/noconnection_view.dart';
import 'package:kahve/product/model/main_view_model/product_model/product_model.dart';
import 'package:kahve/product/router/main_view_router/home_router/home_router.dart';
import 'package:kahve/product/utility/database/home_db/home_db.dart';
import 'package:kahve/product/utility/service/firebase_service.dart';
import 'package:logger/logger.dart';
import '../../../../../product/extension/view_size.dart';

abstract class MainHomeBaseState<T extends StatefulWidget> extends State<T> {
  // model service
  ProductModelService modelService = ProductModelService();
  // router service
  HomeRouterService routerService = HomeRouterService();

  // screens size
  double dynamicWidth(double value) => maxWidth * value;
  double dynamicHeight(double value) => maxHeight * value;

  late final maxWidth = ViewSizeModelExtension(context).mediaSize.width;
  late final maxHeight = ViewSizeModelExtension(context).mediaSize.height;

  @override
  void initState() {
    super.initState();
    setState(() {
      checkControl();
    });
  }

  void checkControl() async {
    bool result = await DataConnectionChecker().hasConnection;
    if (result == true) {
      Logger().i("İnternet Bağlandı!!");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NoConnectionErrorView(),
        ),
      );
    }
  }

  // favorite add
  Future<void> productFavoriteAdd(Map<String, dynamic> data) async {
    return await HomeServiceDB.FAVORITE.productFavoriteRef.doc(data['ID']).set({
      "ID": data['ID'],
      "PRODUCTID": data['ID'],
      "USERID": FirebaseService().authID,
      "DATE": FieldValue.serverTimestamp(),
    }).then((value) {
      final snackBar = SnackBar(
        content: const Text("Ürün Favorilere Eklendi!"),
        action: SnackBarAction(
          label: "Tamam",
          onPressed: () {},
        ),
        duration: const Duration(seconds: 4),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    });
  }

  // delete favorite product delete
  Future<void> productFavoriteDelete(Map<String, dynamic> data) async {
    return await HomeServiceDB.FAVORITE.productFavoriteRef
        .doc(data['ID'])
        .delete()
        .then((value) {
      final snackBar = SnackBar(
        content: const Text("Favorilerden Kaldırıldı"),
        action: SnackBarAction(
          label: "Tamam",
          onPressed: () {},
        ),
        duration: const Duration(seconds: 4),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    });
  }

  // product basket add
  Future<void> productBasketAdd(Map<String, dynamic> data) async {
    if (FirebaseAuth.instance.currentUser != null) {
      final productTable = await FirebaseFirestore.instance
          .collection("BASKET")
          .doc(FirebaseService().authID)
          .collection("PRODUCTS")
          .get();

      if (data['PRODUCTCOFFESTATUS'] == true) {
        if (modelService.isSmallStatus == false &&
            modelService.isMediumStatus == false &&
            modelService.isLargeStatus == false) {
          final snackBar = SnackBar(
            content: const Text(
              "Lütfen Boyut Seçiniz!!",
              textAlign: TextAlign.left,
            ),
            action: SnackBarAction(
              label: "Tamam",
              onPressed: () {},
            ),
            duration: const Duration(
              seconds: 4,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          await FirebaseFirestore.instance
              .collection("BASKET")
              .doc(FirebaseService().authID)
              .collection("PRODUCTS")
              .add({
            "ID": null,
            "PRODUCTID": data['ID'],
            "QUANITY": 0,
            "TOTALPRICE": 0,
            "PRODUCTPRICE": modelService.isSmallStatus == true
                ? data['SMALLPRICE']
                : modelService.isMediumStatus == true
                    ? data['MEDIUMPRICE']
                    : modelService.isLargeStatus == true
                        ? data['LARGEPRICE']
                        : data['PRICE'],
            "PRODUCTCOFFESTATUS": data['PRODUCTCOFFESTATUS'],
            "SMALLPRICE": data['SMALLPRICE'],
            "MEDIUMPRICE": data['MEDIUMPRICE'],
            "LARGEPRICE": data['LARGEPRICE'],
            "COFFESMALLSTATUS": modelService.isSmallStatus,
            "COFFEMEDIUMSTATUS": modelService.isMediumStatus,
            "COFFELARGESTATUS": modelService.isLargeStatus,
            "MAINCATEGORY": data['MAINCATEGORYID'],
            "SUBCATEGORY": data['SUBCATEGORYID'],
            "PRODUCTTITLE": data['TITLE'],
            "PRODUCTSUBTITLE": data['SUBTITLE'],
            "PRODUCTIMG1": data['COVERIMG'],
            "PRODUCTABOUT": data['EXPLANATION'],
            "PRODUCTSELLTYPE": data['SELLTYPE'],
            "DATE": FieldValue.serverTimestamp(),
          }).then((value) async {
            String valueDocID = value.id;
            value.update({"ID": valueDocID});
            final snackBar = SnackBar(
              content: const Text(
                "Ürün Sepepete Eklendi",
                textAlign: TextAlign.left,
              ),
              action: SnackBarAction(
                label: "Tamam",
                onPressed: () {},
              ),
              duration: const Duration(
                seconds: 4,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            await FirebaseFirestore.instance
                .collection("BASKET")
                .doc(FirebaseService().authID)
                .set({
              "USERID": FirebaseService().authID,
            }, SetOptions(merge: true)).then((value) {
              modelService.logger.i("Ürün Eklendi");
            }).catchError((err) {
              modelService.logger.e("Hata Oluştu");
            });
          }).catchError((err) {
            final snackBar = SnackBar(
              content: const Text(
                "Bir Sorun oluştu!",
                textAlign: TextAlign.left,
              ),
              action: SnackBarAction(
                label: "Tamam",
                onPressed: () {},
              ),
              duration: const Duration(
                seconds: 4,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
      } else {
        await FirebaseFirestore.instance
            .collection("BASKET")
            .doc(FirebaseService().authID)
            .collection("PRODUCTS")
            .add({
          "ID": null,
          "PRODUCTID": data['ID'],
          "QUANITY": 0,
          "TOTALPRICE": 0,
          "PRODUCTPRICE": data['PRICE'],
          "PRODUCTCOFFESTATUS": data['PRODUCTCOFFESTATUS'],
          "SMALLPRICE": data['SMALLPRICE'],
          "MEDIUMPRICE": data['MEDIUMPRICE'],
          "LARGEPRICE": data['LARGEPRICE'],
          "MAINCATEGORY": data['MAINCATEGORYID'],
          "SUBCATEGORY": data['SUBCATEGORYID'],
          "PRODUCTTITLE": data['TITLE'],
          "PRODUCTSUBTITLE": data['SUBTITLE'],
          "PRODUCTIMG1": data['COVERIMG'],
          "PRODUCTABOUT": data['EXPLANATION'],
          "PRODUCTSELLTYPE": data['SELLTYPE'],
          "DATE": FieldValue.serverTimestamp(),
        }).then((value) async {
          String valueDocID = value.id;
          value.update({"ID": valueDocID});
          final snackBar = SnackBar(
            content: const Text(
              "Ürün Sepepete Eklendi",
              textAlign: TextAlign.left,
            ),
            action: SnackBarAction(
              label: "Tamam",
              onPressed: () {},
            ),
            duration: const Duration(
              seconds: 4,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          await FirebaseFirestore.instance
              .collection("BASKET")
              .doc(FirebaseService().authID)
              .set({
            "USERID": FirebaseService().authID,
          }, SetOptions(merge: true)).then((value) {
            modelService.logger.i("Ürün Eklendi");
          }).catchError((err) {
            modelService.logger.e("Hata Oluştu");
          });
        }).catchError((err) {
          final snackBar = SnackBar(
            content: const Text(
              "Bir Sorun oluştu!",
              textAlign: TextAlign.left,
            ),
            action: SnackBarAction(
              label: "Tamam",
              onPressed: () {},
            ),
            duration: const Duration(
              seconds: 4,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    } else {
      // Kullanıcı giriş yapmamış
      // İlgili uyarı veya işlemleri burada yapabilirsiniz.
    }
  }
}
