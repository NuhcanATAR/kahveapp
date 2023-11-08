import 'package:flutter/material.dart';

// pub dev

import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/utility/base/log_reg_pass_base/register_base/register_base.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
// routers page

// ignore: camel_case_types
class agrementCheckboxField extends StatefulWidget {
  const agrementCheckboxField({super.key});

  @override
  State<agrementCheckboxField> createState() => _agrementCheckboxFieldState();
}

// ignore: camel_case_types
class _agrementCheckboxFieldState
    extends MainRegisterBase<agrementCheckboxField> {
  bool checkboxValueKey = false;

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (state) {
        return Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Checkbox(
                    activeColor: ColorBackgroundConstant.greenDarker,
                    value: checkboxValueKey,
                    onChanged: (value) {
                      checkboxValueKey = value!;
                      state.didChange(value);
                    },
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        routerService
                            .kahveAgreementViewNavigatorRouter(context);
                      },
                      child: const LabelMediumGreyText(
                        text:
                            "Kullanıcı Sözleşmesini Okudum ve kabul ediyorum.",
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              state.errorText ?? '',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        );
      },
      validator: (value) {
        if (!checkboxValueKey) {
          return 'Kullanıcı Sözleşmesini Onaylamanız Gerek!';
        }
        return null;
      },
    );
  }
}
