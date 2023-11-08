import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  dynamic userAuth = FirebaseAuth.instance;
  dynamic cloudFireStore = FirebaseFirestore.instance;
  final authID = FirebaseAuth.instance.currentUser!.uid;
}
