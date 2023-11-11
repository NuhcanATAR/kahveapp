import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/widget/text_widget/body_medium_text.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class ProfileTopCard extends StatelessWidget {
  const ProfileTopCard({
    super.key,
    required this.data,
    required this.maxWidth,
    required this.dynamicWidth,
    required this.dynamicHeight,
  });
  final dynamic maxWidth;
  final dynamic dynamicWidth;
  final dynamic dynamicHeight;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // profile image
        buildProfileimgWidget,
        // user name surname & location
        buildUserNameSurnameLocationWidget,
      ],
    );
  }

  // profile image
  Widget get buildProfileimgWidget => SizedBox(
        width: dynamicWidth(0.27),
        height: dynamicHeight(0.15),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(
                  "https://firebasestorage.googleapis.com/v0/b/kahvedb.appspot.com/o/icons8-account-64.png?alt=media&token=dc85c94b-1639-4de6-bee0-551d83832106"),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
        ),
      );

  // user name surname & location
  Widget get buildUserNameSurnameLocationWidget => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              // name surname
              SizedBox(
                width: maxWidth,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: BodyMediumBlackBoldText(
                      text: data['NAMESURNAME'],
                      textAlign: TextAlign.left,
                    )),
              ),
              // location
              SizedBox(
                width: maxWidth,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: <Widget>[
                        // ıcon
                        Icon(
                          Icons.email_outlined,
                          color: ColorBackgroundConstant.greenDarker,
                          size: 17,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        // location
                        LabelMediumGreyText(
                            textAlign: TextAlign.left, text: data['EMAIL'])
                      ],
                    )),
              ),
            ],
          ),
        ),
      );
}
