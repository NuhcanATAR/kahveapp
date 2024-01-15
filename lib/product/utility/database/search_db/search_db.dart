// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

enum SearchDB {
  MAINCATEGORY,
  PRODUCTS;

  // one-time query parameter
  Future<DocumentSnapshot<Map<String, dynamic>>> productMainCategoryRef(
          Map<String, dynamic> data) =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(data['MAINCATEGORYID'])
          .get();

  //  list query parameter
  Stream<QuerySnapshot<Map<String, dynamic>>> get productShowCaseList =>
      FirebaseFirestore.instance
          .collection(name)
          .where("ACTIVE", isEqualTo: true)
          .snapshots();
}
