// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kahve/product/utility/service/firebase_service.dart';

enum ProfileDb {
  ADRESS,
  USERS;

  Future<DocumentSnapshot<Map<String, dynamic>>> get userRef =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(FirebaseService().authID)
          .get();

  CollectionReference<Map<String, dynamic>> get userAdressDoc =>
      FirebaseFirestore.instance.collection(name);

  Stream<QuerySnapshot> get userAdressListQuery => FirebaseFirestore.instance
      .collection(name)
      .where("USERID", isEqualTo: FirebaseService().authID)
      .snapshots();

  DocumentReference<Map<String, dynamic>> userAdressRef(
          Map<String, dynamic> data) =>
      FirebaseFirestore.instance.collection(name).doc(data['ID']);
}
