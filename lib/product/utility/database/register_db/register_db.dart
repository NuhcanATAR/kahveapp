import 'package:cloud_firestore/cloud_firestore.dart';

enum RegisterDb {
  USERS;

  CollectionReference get userRef =>
      FirebaseFirestore.instance.collection(name);
}
