import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/model/main_view_model/profile_model/profile_model.dart';
import 'package:kahve/product/utility/base/main_view_base/profile_base/profile_base.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class CreateAdressView extends StatefulWidget {
  const CreateAdressView({super.key});

  @override
  State<CreateAdressView> createState() => _CreateAdressViewState();
}

class _CreateAdressViewState extends MainProfileBase<CreateAdressView> {
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
          text: "Adres Oluştur",
          textAlign: TextAlign.center,
        ),
      ),
      body: Form(
        key: modelService.formAdressAddKey,
        child: Padding(
          padding: context.padding.normal,
          child: ListView(
            children: <Widget>[
              // adres title
              buildAdressTitleWidget,
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
          controller: modelService.adressTitleController,
          validator: modelService.adressTitleValidator,
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
            value: modelService.selectCityValue,
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
                modelService.selectCityValue = value!;
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
          controller: modelService.adressDescriptionController,
          validator: modelService.adressDescriptionValidator,
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
          if (modelService.formAdressAddKey.currentState!.validate()) {
            adressCreate();
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
              text: "Adresi Kaydet",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}
