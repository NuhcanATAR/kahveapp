// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/model/main_view_model/basket_model/basket_model.dart';
import 'package:kahve/product/router/main_view_router/basket_router/basket_router.dart';
import 'package:kahve/product/utility/database/basket_db/basket_db.dart';
import 'package:kahve/product/utility/service/firebase_service.dart';
import 'package:logger/logger.dart';
import '../../../../../product/extension/view_size.dart';

abstract class MainBasketBase<T extends StatefulWidget> extends State<T>
    with BasketMixinVoid {
  // model service
  BasketModelService modelService = BasketModelService();
  // router service
  BasketRouterService routerService = BasketRouterService();
  // screens size
  double dynamicWidth(double value) => maxWidth * value;
  double dynamicHeight(double value) => maxHeight * value;

  late final maxWidth = ViewSizeModelExtension(context).mediaSize.width;
  late final maxHeight = ViewSizeModelExtension(context).mediaSize.height;

  @override
  void initState() {
    super.initState();
    fetchRefCategories();
    title = [];
  }

  late List<AdressLocations> title;
  AdressLocations? selectTitle;

  void fetchRefCategories() async {
    final snapshotCategory = await FirebaseFirestore.instance
        .collection("ADRESS")
        .where("USERID", isEqualTo: FirebaseService().authID)
        .get();
    setState(() {
      title = snapshotCategory.docs
          .map((docCategory) => AdressLocations.fromSnapshot(docCategory))
          .toList();
    });
  }

  Future<void> basketSelectProductDelete(Map<String, dynamic> data) async {
    final productBasketTableRef = await BasketDB.BASKET.basketMainDocumentsRef;

    final Map<String, dynamic>? dataMap = productBasketTableRef.data();
    if (productBasketTableRef.exists) {
      final productBasketQuanityValue = dataMap?['TOTALQUANITY'] ?? 0;
      final productBasketTotalPrice = dataMap?['TOTALPRICE'] ?? 0;

      final productTotalPrice = data['TOTALPRICE'] ?? 0;
      final productQuanityValue = data['QUANITY'] ?? 0;

      // 'data' içindeki değerler null değilse işlemleri gerçekleştir
      await BasketDB.BASKET.basketMainDocumentsSetRef.set({
        "USERID": FirebaseService().authID,
        "TOTALPRICE": productBasketTotalPrice == 0
            ? 0
            : productBasketTotalPrice - productTotalPrice,
        "TOTALQUANITY": productBasketQuanityValue == 0
            ? 0
            : productBasketQuanityValue - productQuanityValue,
      }).then((value) async {
        Logger().i("Ürün adeti ve toplam fiyatı genel yapıdan çıkarıldı");
        await FirebaseFirestore.instance
            .collection("BASKET")
            .doc(FirebaseService().authID)
            .collection("PRODUCTS")
            .doc(data['ID'])
            .delete()
            .then((value) {
          final snackBar = SnackBar(
            content: const Text("Ürün Sepetten Kaldırıldı"),
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
            content: const Text("Hata Oluştu"),
            action: SnackBarAction(
              label: "Tamam",
              onPressed: () {},
            ),
            duration: const Duration(
              seconds: 3,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }).catchError((err) {
        Logger().e("hata");
      });
    } else {
      Logger().e("Belge bulunamadı veya alanlar mevcut değil.");
    }
  }

  // basket product quanity add
  Future<void> basketSelectProductQuanityAdd(Map<String, dynamic> data) async {
    try {
      int currentQuantity = data['QUANITY'] ?? 0;
      int newQuantity = currentQuantity + 1;

      // Ürünün adetini güncelle
      await BasketDB.BASKET.basketSelectProductQuanityUpdate(data).update({
        "QUANITY": newQuantity,
      });

      // Sepetteki tüm ürünlerin adetini topla
      QuerySnapshot<Map<String, dynamic>> basketSnapshot =
          await FirebaseFirestore.instance
              .collection("BASKET")
              .doc(FirebaseService().authID)
              .collection("PRODUCTS")
              .get();

      num totalQuantity = 0;

      for (QueryDocumentSnapshot<Map<String, dynamic>> basketDocument
          in basketSnapshot.docs) {
        totalQuantity += (basketDocument.data()['QUANITY'] ?? 0) as num;
      }

      // Toplam adeti güncelle
      await BasketDB.BASKET.basketMainDocumentsSetRef.update({
        "TOTALQUANITY": totalQuantity,
      });

      await BasketDB.BASKET.basketSelectProductQuanityUpdate(data).update({
        "TOTALPRICE": newQuantity * data['PRODUCTPRICE'],
      }).then((value) async {
        num totalPriceQuanityValue = data['PRODUCTPRICE'];
        for (QueryDocumentSnapshot<Map<String, dynamic>> basketDocument
            in basketSnapshot.docs) {
          totalPriceQuanityValue +=
              (basketDocument.data()['TOTALPRICE'] ?? 0) as num;
        }

        await BasketDB.BASKET.basketMainDocumentsSetRef.update({
          "TOTALPRICE": totalPriceQuanityValue,
        });
      });

      modelService.logger.i("Ürün Adeti +1 Arttırıldı");
    } catch (error) {
      modelService.logger.e("Hata");
    }
  }

  // basket product quanity decreasing
  Future<void> basketSelectProductQuanityDecreasing(
      Map<String, dynamic> data) async {
    try {
      int currentQuantity = data['QUANITY'] ?? 0;

      if (currentQuantity > 1) {
        int newQuantity = currentQuantity - 1;

        // Ürünün adetini güncelle
        await BasketDB.BASKET.basketSelectProductQuanityUpdate(data).update({
          "QUANITY": newQuantity,
          "TOTALPRICE": newQuantity * data['PRODUCTPRICE'],
        });

        // Sepetteki tüm ürünlerin adetini ve toplam fiyatını topla
        QuerySnapshot<Map<String, dynamic>> basketSnapshot =
            await FirebaseFirestore.instance
                .collection("BASKET")
                .doc(FirebaseService().authID)
                .collection("PRODUCTS")
                .get();

        num totalQuantity = 0;
        num totalPriceQuantityValue = 0;

        for (QueryDocumentSnapshot<Map<String, dynamic>> basketDocument
            in basketSnapshot.docs) {
          totalQuantity += (basketDocument.data()['QUANITY'] ?? 0) as num;
          totalPriceQuantityValue +=
              (basketDocument.data()['TOTALPRICE'] ?? 0) as num;
        }

        // Toplam adeti ve toplam fiyatı güncelle
        await BasketDB.BASKET.basketMainDocumentsSetRef.update({
          "TOTALQUANITY": totalQuantity,
          "TOTALPRICE": totalPriceQuantityValue,
        });

        modelService.logger.i("Ürün Adeti -1 Azaltıldı");
      } else {
        // Eğer mevcut adet 1 ise, azaltma işlemi yapılamaz, kullanıcıya uyarı göster
        final snackBar = SnackBar(
          content: const Text("Ürün adeti 1'den küçük olamaz"),
          action: SnackBarAction(
            label: "Tamam",
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (error) {
      // Hata durumunda bildirim göster
      final snackBar = SnackBar(
        content: const Text("Hata Oluştu:("),
        action: SnackBarAction(
          label: "Tamam",
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  // product quanity and total price control
  Future<void> basketQuanityAndTotalPriceControl() async {
    final productBasketStatus = await BasketDB.BASKET.basketMainDocumentsRef;
    final productMainTotalPrice = productBasketStatus['TOTALPRICE'] ?? 0;
    final productMainTotalQuanityValue =
        productBasketStatus['TOTALQUANITY'] ?? 0;

    if (productBasketStatus.exists) {
      if (productMainTotalPrice == 0 && productMainTotalQuanityValue == 0) {
        final snackBar = SnackBar(
          content: const Text("Adet Değerleri Belirlenmedi!"),
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
        routerService.paymentTypeSelectViewNavigatorRouter(context);
      }
    } else {
      modelService.logger.i("Kolon Bulunamadı");
    }
  }

  // order main information saved
  Future<void> orderMainInformationSaved() async {
    if (modelService.isAgreementStatus == false) {
      final snackBar = SnackBar(
        content: const Text("Lütfen Sözleşmeyi Onaylayınız!"),
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
      await BasketDB.BASKET.basketMainDocumentsSetRef.set(
        {
          "CONTRACTSTATUS": modelService.isAgreementStatus,
          "ADRESSTITLE": selectTitle!.title,
          "ADRESSDESCRIPTION": selectTitle!.description,
          "ADRESSUSERNAME": selectTitle!.name,
          "ADRESSSURNAME": selectTitle!.surname,
          "ADRESSPHONENUMBER": selectTitle!.phoneNumber,
          "ADRESSCITY": selectTitle!.city,
          "ADRESSUSERID": selectTitle!.userID,
          "PAYMENTTYPE": modelService.paymentTypes == PaymentType.cardPay
              ? "Kart ile Ödeme"
              : "Nakit Ödeme",
        },
        SetOptions(merge: true),
      ).then((value) {
        final snackBar = SnackBar(
          content: const Text("Bilgiler Kaydedildi!"),
          action: SnackBarAction(
            label: "Tamam",
            onPressed: () {},
          ),
          duration: const Duration(seconds: 4),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        routerService.orderConfirmationViewNavigatorRouter(context);
      }).catchError((err) {
        final snackBar = SnackBar(
          content: const Text("Hata oluştu! Tekrar Deneyiniz."),
          action: SnackBarAction(
            label: "Tamam",
            onPressed: () {},
          ),
          duration: const Duration(seconds: 4),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  // order create
  Future<void> orderCreate(Map<String, dynamic> data, productList) async {
    await BasketDB.ORDERSETTING.orderDetailCollectionRef.add({
      "ORDERID": null,
      "ADRESSCITY": data['ADRESSCITY'],
      "ADRESSDESCRIPTION": data['ADRESSDESCRIPTION'],
      "ADRESSCITYVALUE": data['ADRESSCITY'],
      "ADRESSUSERPHONENUMBER": data['ADRESSPHONENUMBER'],
      "ADRESSUSERSURNAME": data['ADRESSSURNAME'],
      "ADRESSTITLE": data['ADRESSTITLE'],
      "ADRESSUSERNAME": data['ADRESSUSERNAME'],
      "CONTRACTSTATUS": true,
      "ORDERSTATUS": false,
      "PAYMENTTYPE": data['PAYMENTTYPE'],
      "TOTALPRICE": data['TOTALPRICE'],
      "TOTALQUANITY": data['TOTALQUANITY'],
      "USERIDVALUE": data['USERID'],
      "ORDERDAY": DateTime.now().day,
      "ORDERMONTH": DateTime.now().month,
      "ORDERYEAR": DateTime.now().year,
      "ORDERHOUR": DateTime.now().hour,
      "ORDERMINUTE": DateTime.now().minute,
      "DATE": FieldValue.serverTimestamp(),
      "ORDERINPROGRESSSTATUS": false,
      "CARGOSTATUS": false,
      "DELIVERED": false,
      "ORDERTRACKINGSTATUS": "Bilinmiyor",
      "ORDERREJECT": false,
    }).then((value) async {
      late String docID = value.id;
      value.update({"ORDERID": docID});

      for (DocumentSnapshot document in productList) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        await BasketDB.ORDERPRODUCTS.orderProductsTableRef.add({
          "ID": null,
          "ORDERID": docID,
          "PRODUCTTITLE": data['PRODUCTTITLE'],
          "SUBCATEGORY": data['SUBCATEGORY'],
          "PRODUCTABOUT": data['PRODUCTABOUT'],
          "PRODUCTID": data['PRODUCTID'],
          "PRODUCTIMG1": data['PRODUCTIMG1'],
          "PRODUCTPRICE": data['PRODUCTPRICE'],
          "PRODUCTSELLTYPE": data['PRODUCTSELLTYPE'],
          "PRODUCTSUBTITLE": data['PRODUCTSUBTITLE'],
          "PRODUCTCOFFESTATUS": data['PRODUCTCOFFESTATUS'],
          "COFFESMALLSTATUS": data['COFFESMALLSTATUS'],
          "COFFEMEDIUMSTATUS": data['COFFEMEDIUMSTATUS'],
          "COFFELARGESTATUS": data['COFFELARGESTATUS'],
          "QUANITY": data['QUANITY'],
          "TOTALPRICE": data['TOTALPRICE'],
        }).then((value) {
          late String docOrderProductID = value.id;
          value.update({"ID": docOrderProductID});
          modelService.logger.i("Ürün Sipariş Ürünleri Tablosuna Eklendi!");
        }).catchError((err) {
          modelService.logger.e("Hata Oluştu!");
        });
      }

      for (DocumentSnapshot document in productList) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        await BasketDB.BASKET.basketSelectProductQuanityUpdate(data).delete();
      }
      await FirebaseFirestore.instance
          .collection("BASKET")
          .doc(FirebaseService().authID)
          .delete();
      routerService.orderEndLoadingViewNavigatorRouter(context);
    }).catchError((err) {
      final snackBar = SnackBar(
        content: const Text("Hata oluştu, Tekrar Deneyiniz!"),
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
}
