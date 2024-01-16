// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kahve/product/utility/service/firebase_service.dart';

enum BasketDB {
  AGREEMENT,
  BASKET,
  MAINCATEGORY,
  ORDERPRODUCTS,
  ORDERSETTING,
  PRODUCTS;

  // one-time query parameter

  CollectionReference get orderProductsTableRef =>
      FirebaseFirestore.instance.collection(name);

  CollectionReference get orderDetailCollectionRef =>
      FirebaseFirestore.instance.collection(name);

  Future<DocumentSnapshot<Map<String, dynamic>>> get userAgreementRef =>
      FirebaseFirestore.instance
          .collection(name)
          .doc("z7vOqfZtFM2zgJgtUiQ1")
          .get();

  Future<DocumentSnapshot<Map<String, dynamic>>> productMainCategoryRef(
          Map<String, dynamic> data) =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(data['MAINCATEGORY'])
          .get();

  Future<DocumentSnapshot<Map<String, dynamic>>> get basketMainDocumentsRef =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(FirebaseService().authID)
          .get();

  DocumentReference<Map<String, dynamic>> basketSelectProductQuanityUpdate(
          data) =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(FirebaseService().authID)
          .collection("PRODUCTS")
          .doc(data['ID']);

  Future<DocumentSnapshot<Map<String, dynamic>>> productRef(
          Map<String, dynamic> data) =>
      FirebaseFirestore.instance.collection(name).doc(data['PRODUCTID']).get();

  DocumentReference<Map<String, dynamic>> get basketMainDocumentsSetRef =>
      FirebaseFirestore.instance.collection(name).doc(FirebaseService().authID);

  // list query parameter
  Stream<QuerySnapshot> get productBasketListQuery => FirebaseFirestore.instance
      .collection(name)
      .doc(FirebaseService().authID)
      .collection("PRODUCTS")
      .orderBy("DATE", descending: true)
      .snapshots();

  Stream<DocumentSnapshot<Map<String, dynamic>>> get productBasket =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(FirebaseService().authID)
          .snapshots();

  Stream<QuerySnapshot> get basketListQuery => FirebaseFirestore.instance
      .collection(name)
      .doc(FirebaseService().authID)
      .collection("PRODUCTS")
      .snapshots();
}
