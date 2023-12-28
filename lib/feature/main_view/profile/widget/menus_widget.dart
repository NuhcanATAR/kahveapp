import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class MenusWidget extends StatelessWidget {
  const MenusWidget({
    super.key,
    required this.data,
    required this.maxWidth,
    required this.dynamicWidth,
    required this.dynamicHeight,
    required this.nameSurnameUpdViewRouter,
    required this.emailUpdViewRouter,
    required this.ordersViewRouter,
    required this.savedAdressViewRouter,
    required this.nameSurnameUpd,
    required this.accountExitDialog,
  });
  final dynamic maxWidth;
  final dynamic dynamicWidth;
  final dynamic dynamicHeight;
  final Map<String, dynamic> data;
  final dynamic nameSurnameUpdViewRouter;
  final dynamic emailUpdViewRouter;
  final dynamic ordersViewRouter;
  final dynamic savedAdressViewRouter;
  final dynamic nameSurnameUpd;
  final dynamic accountExitDialog;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: dynamicHeight(0.03),
        ),
        // user edit mennu
        buildUserEditMenuWidget(
            context, data, maxWidth, dynamicHeight, nameSurnameUpd),
        // maıl update menu
        buildMailupdateMenuWidget(context),
        // orders
        buildOrdersMenuWidget(context),
        // order adress
        buildOrderAdressMenuWidget(context),
        // exit account
        buildExitAccountMenuWidget(context),
      ],
    );
  }

  // user edit mennu
  Widget buildUserEditMenuWidget(
          context, data, maxWidth, dynamicHeight, nameSurnameUpd) =>
      Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: GestureDetector(
          onTap: () {
            nameSurnameUpdViewRouter(
                context, data, maxWidth, dynamicHeight, nameSurnameUpd);
          },
          child: Row(
            children: <Widget>[
              Icon(
                Icons.edit,
                color: ColorBackgroundConstant.greenDarker,
                size: 18,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: LabelMediumBlackText(
                    text: "Ad Soyad Güncelle",
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: ColorBackgroundConstant.greenDarker,
                size: 18,
              ),
            ],
          ),
        ),
      );

  // maıl update menu
  Widget buildMailupdateMenuWidget(context) => Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: GestureDetector(
          onTap: () {
            emailUpdViewRouter(context);
          },
          child: Row(
            children: <Widget>[
              Icon(
                Icons.mail,
                color: ColorBackgroundConstant.greenDarker,
                size: 18,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: LabelMediumBlackText(
                    text: "Email Değişikliği",
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: ColorBackgroundConstant.greenDarker,
                size: 18,
              ),
            ],
          ),
        ),
      );

  // orders
  Widget buildOrdersMenuWidget(context) => Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: GestureDetector(
          onTap: () {
            ordersViewRouter(context);
          },
          child: Row(
            children: <Widget>[
              Icon(
                Icons.shopping_basket,
                color: ColorBackgroundConstant.greenDarker,
                size: 18,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: LabelMediumBlackText(
                    text: "Siparişler",
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: ColorBackgroundConstant.greenDarker,
                size: 18,
              ),
            ],
          ),
        ),
      );

  // order adress
  Widget buildOrderAdressMenuWidget(context) => Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: GestureDetector(
          onTap: () {
            savedAdressViewRouter(context);
          },
          child: Row(
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: ColorBackgroundConstant.greenDarker,
                size: 18,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: LabelMediumBlackText(
                    text: "Kayıtlı Adreslerim",
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: ColorBackgroundConstant.greenDarker,
                size: 18,
              ),
            ],
          ),
        ),
      );

  // exit account
  Widget buildExitAccountMenuWidget(context) => Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: GestureDetector(
          onTap: () {
            accountExitDialog(context);
          },
          child: const Row(
            children: <Widget>[
              Icon(
                Icons.exit_to_app,
                color: Colors.red,
                size: 18,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: LabelMediumRedColorText(
                    text: "Hesaptan çıkış yap",
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.red,
                size: 18,
              ),
            ],
          ),
        ),
      );
}
