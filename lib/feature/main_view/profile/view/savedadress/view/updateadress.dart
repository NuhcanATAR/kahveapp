import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/model/main_view_model/profile_model/profile_model.dart';
import 'package:kahve/product/utility/base/main_view_base/profile_base/profile_base.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class UpdateAdressView extends StatefulWidget {
  const UpdateAdressView({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  State<UpdateAdressView> createState() => _UpdateAdressViewState();
}

class _UpdateAdressViewState extends MainProfileBase<UpdateAdressView> {
  late TextEditingController adressNameController = TextEditingController(
    text: widget.data['NAME'],
  );

  late TextEditingController adressSurnameController = TextEditingController(
    text: widget.data['SURNAME'],
  );

  late TextEditingController adressPhoneNumberController =
      TextEditingController(
    text: widget.data['PHONENUMBER'],
  );
  late TextEditingController adressTitleController = TextEditingController(
    text: widget.data['ADRESSTITLE'],
  );

  late String adressCityValue = widget.data['CITY'];

  late TextEditingController adressDescriptionController =
      TextEditingController(
    text: widget.data['ADRESSDESCRIPTION'],
  );

  late String newTitle = widget.data['ADRESSTITLE'];
  late String newDescription = widget.data['ADRESSDESCRIPTION'];
  late String newName = widget.data['NAME'];
  late String newSurname = widget.data['SURNAME'];
  late String newPhoneNumber = widget.data['PHONENUMBER'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorBackgroundConstant.greenDarker,
            size: 20,
          ),
        ),
        title: const LabelMediumMainColorText(
          text: "Adres Güncelle",
          textAlign: TextAlign.center,
        ),
      ),
      body: Form(
        key: modelService.formAdressUpdKey,
        child: Padding(
          padding: context.padding.normal,
          child: ListView(
            children: <Widget>[
              // name surname
              buildNameSurnameWidget,
              // adres title
              buildAdressTitleWidget,
              // phone number
              buildPhoneNumberWidget,
              // select city
              buildAdressSelectCityWidget,
              // adress description
              buildAdressDescriptionWidget,
              // saved button
              buildAdressSavedButtonWidget,
            ],
          ),
        ),
      ),
    );
  }

  // name surname
  Widget get buildNameSurnameWidget => Row(
        children: <Widget>[
          // NAME
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: TextFormField(
                controller: adressNameController,
                validator: modelService.adressNameValidator,
                onChanged: (String value) {
                  setState(() {
                    newName = value;
                  });
                },
                style: GoogleFonts.nunito(
                  textStyle: context.general.textTheme.labelMedium?.copyWith(
                    color: Colors.black,
                  ),
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Ad *",
                ),
              ),
            ),
          ),
          // SURNAME
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: TextFormField(
                controller: adressSurnameController,
                validator: modelService.adressSurnameValidator,
                onChanged: (String value) {
                  setState(() {
                    newSurname = value;
                  });
                },
                style: GoogleFonts.nunito(
                  textStyle: context.general.textTheme.labelMedium?.copyWith(
                    color: Colors.black,
                  ),
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Soyad *",
                ),
              ),
            ),
          ),
        ],
      );

  // adres title
  Widget get buildAdressTitleWidget => Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: TextFormField(
          controller: adressTitleController,
          validator: modelService.adressTitleValidator,
          onChanged: (String value) {
            setState(() {
              newTitle = value;
            });
          },
          style: GoogleFonts.nunito(
            textStyle: context.general.textTheme.labelMedium?.copyWith(
              color: Colors.black,
            ),
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Adres Başlığı *",
          ),
        ),
      );

  // phone number
  Widget get buildPhoneNumberWidget => Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: TextFormField(
          controller: adressPhoneNumberController,
          validator: modelService.adressPhoneNumberValidator,
          onChanged: (value) {
            setState(() {
              newPhoneNumber = value;
            });
          },
          style: GoogleFonts.nunito(
            textStyle: context.general.textTheme.labelMedium?.copyWith(
              color: Colors.black,
            ),
          ),
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Telefon Numarası *",
          ),
        ),
      );

  // select city
  Widget get buildAdressSelectCityWidget => Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            value: adressCityValue,
            validator: (value) => value == null ? "Zorunlu Alan *" : null,
            icon: const Icon(
              Icons.location_on,
              color: Colors.grey,
              size: 18,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            elevation: 16,
            style: GoogleFonts.nunito(
              textStyle: context.general.textTheme.labelMedium?.copyWith(
                color: Colors.black,
              ),
            ),
            onChanged: (String? value) {
              setState(() {
                adressCityValue = value!;
              });
            },
            items: cityList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      );

  // adress description
  Widget get buildAdressDescriptionWidget => Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: TextFormField(
          controller: adressDescriptionController,
          validator: modelService.adressDescriptionValidator,
          onChanged: (String value) {
            setState(() {
              newDescription = value;
            });
          },
          style: GoogleFonts.nunito(
            textStyle: context.general.textTheme.labelMedium?.copyWith(
              color: Colors.black,
            ),
          ),
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 5,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Adres Açıklama *",
          ),
        ),
      );

  // saved button
  Widget get buildAdressSavedButtonWidget => GestureDetector(
        onTap: () {
          if (modelService.formAdressUpdKey.currentState!.validate()) {
            adressEdit(
              widget.data,
              newTitle,
              newDescription,
              adressCityValue,
              newName,
              newSurname,
              newPhoneNumber,
            );
          }
        },
        child: SizedBox(
          width: maxWidth,
          height: dynamicHeight(0.07),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorBackgroundConstant.greenDarker,
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: const LabelMediumWhiteText(
              text: "Adresi Güncelle",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}
