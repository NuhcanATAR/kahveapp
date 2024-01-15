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

  dynamic logger = Logger();
}
