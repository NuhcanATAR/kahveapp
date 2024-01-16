import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class AdressLocations {
  final String id;
  final String title;
  final String description;
  final String name;
  final String surname;
  final String phoneNumber;
  final String city;
  final String userID;

  AdressLocations(
      {required this.id,
      required this.title,
      required this.description,
      required this.name,
      required this.surname,
      required this.phoneNumber,
      required this.city,
      required this.userID});

  factory AdressLocations.fromSnapshot(DocumentSnapshot snapshot) {
    return AdressLocations(
        id: snapshot.id,
        title: snapshot['ADRESSTITLE'],
        description: snapshot['ADRESSDESCRIPTION'],
        name: snapshot['NAME'],
        surname: snapshot['SURNAME'],
        city: snapshot['CITY'],
        phoneNumber: snapshot['PHONENUMBER'],
        userID: snapshot['USERID']);
  }
}

enum NullTypes { selectType }

enum PaymentType { cardPay, cashPay }

class BasketModelService {
  NullTypes? selectTypes = NullTypes.selectType;

  late bool isAgreementStatus = false;

  dynamic logger = Logger();

  PaymentType? paymentTypes = PaymentType.cardPay;
}
