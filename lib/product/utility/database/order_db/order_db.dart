// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

enum OrderServiceDB {
  PRODUCTS,
  ORDERSETTING,
  ORDERPRODUCTS;

  // one-time query parameter
  Future<DocumentSnapshot<Map<String, dynamic>>> productRef(
          Map<String, dynamic> data) =>
      FirebaseFirestore.instance.collection(name).doc(data['PRODUCTID']).get();

  // list query parameter
  Stream<QuerySnapshot> get orderSettingList => FirebaseFirestore.instance
      .collection(name)
      .orderBy("DATE", descending: true)
      .snapshots();

  Stream<QuerySnapshot> orderProductsList(Map<String, dynamic> data) =>
      FirebaseFirestore.instance
          .collection(name)
          .where("ORDERID", isEqualTo: data['ORDERID'])
          .snapshots();
}
