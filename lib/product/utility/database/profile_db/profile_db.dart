// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kahve/product/utility/service/firebase_service.dart';

enum ProfileDb {
  USERS;

  Future<DocumentSnapshot<Map<String, dynamic>>> get userRef =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(FirebaseService().authID)
          .get();
}
