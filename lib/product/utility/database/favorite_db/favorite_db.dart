import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kahve/product/utility/service/firebase_service.dart';

enum FavoriteServiceDB {
  FAVORITE,
  PRODUCTS;

  // one-time query parameter
  Future<DocumentSnapshot<Map<String, dynamic>>> productRef(
          Map<String, dynamic> data) =>
      FirebaseFirestore.instance.collection(name).doc(data['PRODUCTID']).get();

  // list query parameter
  Stream<QuerySnapshot> get favoriteListQuery => FirebaseFirestore.instance
      .collection(name)
      .orderBy('DATE', descending: true)
      .snapshots();
}
