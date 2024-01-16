import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

List<String> cityList = <String>[
  "Çorum",
  "Ankara",
  "Kırıkkale",
];

class ProfileServiceModel {
  // form key
  final formAdressAddKey = GlobalKey<FormState>();
  final formAdressUpdKey = GlobalKey<FormState>();

  // controller
  late TextEditingController adressTitleController = TextEditingController();
  late TextEditingController adressDescriptionController =
      TextEditingController();
  late TextEditingController adressNameController = TextEditingController();
  late TextEditingController adressSurnameController = TextEditingController();
  late TextEditingController adressPhoneNumberController =
      TextEditingController();

  late String selectCityValue = cityList.first;

  // validator
  String? adressTitleValidator(String? adressTitleVal) {
    if (adressTitleVal == null || adressTitleVal.isEmpty) {
      return "Zorunlu Alan!";
    } else {
      return null;
    }
  }

  String? adressDescriptionValidator(String? adressDescrtiptionVal) {
    if (adressDescrtiptionVal == null || adressDescrtiptionVal.isEmpty) {
      return "Zorunlu Alan!";
    } else {
      return null;
    }
  }

  String? adressNameValidator(String? adressNameVal) {
    if (adressNameVal == null || adressNameVal.isEmpty) {
      return "Zorunlu Alan!";
    } else {
      return null;
    }
  }

  String? adressSurnameValidator(String? adressSurnameVal) {
    if (adressSurnameVal == null || adressSurnameVal.isEmpty) {
      return "Zorunlu Alan!";
    } else {
      return null;
    }
  }

  String? adressPhoneNumberValidator(String? adressPhoneNumberVal) {
    if (adressPhoneNumberVal == null || adressPhoneNumberVal.isEmpty) {
      return "Zorunlu Alan!";
    } else {
      return null;
    }
  }

  dynamic logger = Logger();
}
