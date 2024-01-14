import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kahve/product/utility/service/firebase_service.dart';

enum HomeServiceDB {
  USERS,
  PRODUCTS,
  MAINCATEGORY,
  SUBCATEGORY,
  BLOGS,
  BANNERS;

  // one-time query parameter

  Future<DocumentSnapshot<Map<String, dynamic>>> get userRefTable =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(FirebaseService().authID)
          .get();

  CollectionReference get productRefTable =>
      FirebaseFirestore.instance.collection(name);

  Future<DocumentSnapshot<Map<String, dynamic>>> productMainCategoryRef(
          Map<String, dynamic> data) =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(data['MAINCATEGORYID'])
          .get();

  Future<DocumentSnapshot<Map<String, dynamic>>> productSubCategoryRef(
          Map<String, dynamic> data) =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(data['SUBCATEGORYID'])
          .get();

  // list query parameter

  Stream<QuerySnapshot<Map<String, dynamic>>> get subCategory =>
      FirebaseFirestore.instance
          .collection(name)
          .where("ACTIVE", isEqualTo: true)
          .snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> get productShowCaseList =>
      FirebaseFirestore.instance
          .collection(name)
          .orderBy('DATE', descending: true)
          .snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> get mainCategoryList =>
      FirebaseFirestore.instance.collection(name).snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> subCategoryList(
          Map<String, dynamic> data) =>
      FirebaseFirestore.instance
          .collection(name)
          .where("MAINCATEGORYID", isEqualTo: data['ID'])
          .snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> get appBlogList =>
      FirebaseFirestore.instance
          .collection(name)
          .orderBy('DATE', descending: true)
          .snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> get appBannerSliderList =>
      FirebaseFirestore.instance
          .collection(name)
          .where("ACTIVE", isEqualTo: true)
          .snapshots();
}
