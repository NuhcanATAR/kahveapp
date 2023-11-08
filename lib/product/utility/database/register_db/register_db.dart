// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

enum RegisterDb {
  USERS;

  CollectionReference get userRef =>
      FirebaseFirestore.instance.collection(name);
}
