import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/enums/home_enums.dart';
import 'package:kahve/product/utility/database/home_db/home_db.dart';
import 'package:kahve/product/widget/text_widget/body_medium_text.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class BlogListWidget extends StatelessWidget {
  const BlogListWidget(
      {required this.routerService,
      required this.maxWidth,
      required this.dynamicHeight,
      required this.dynamicWidth,
      super.key});

  final dynamic routerService;
  final dynamic maxWidth;
  final dynamic dynamicHeight;
  final dynamic dynamicWidth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: HomeServiceDB.BLOGS.appBlogList,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const SizedBox();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }

        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.docs.isNotEmpty) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Column(
              children: <Widget>[
                // title
                SizedBox(
                  width: maxWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 15),
                    child: LabelMediumBlackBoldText(
                      text: HomeStrings.blogTitleText.value,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                // list
                Column(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    if (data['ACTIVE'] == true) {
                      return buildBlogCardWidget(context, data);
                    } else {
                      return const SizedBox();
                    }
                  }).toList(),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  // blog card widget
  Widget buildBlogCardWidget(context, data) => GestureDetector(
        onTap: () {
          routerService.blogDetailViewNavigatorRouter(context, data);
        },
        child: Card(
          child: SizedBox(
            width: maxWidth,
            height: dynamicHeight(0.17),
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  // cover ımg
                  buildCoverImgWidget(context, data),
                  // title, sub title
                  buildTitleSubTitleWidget(context, data),
                ],
              ),
            ),
          ),
        ),
      );

  // cover img widget
  Widget buildCoverImgWidget(context, data) => Flexible(
        fit: FlexFit.tight,
        flex: 2,
        child: Container(
          padding: const EdgeInsets.all(5),
          alignment: Alignment.center,
          child: CachedNetworkImage(
            imageUrl: data['IMG'],
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  )),
            ),
            placeholder: (context, url) => Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
          ),
        ),
      );

  // title & sub title widget
  Widget buildTitleSubTitleWidget(context, data) => Expanded(
        flex: 4,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // title
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: SizedBox(
                    width: maxWidth,
                    child: BodyMediumBlackBoldText(
                      text: data['TITLE'],
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                // sub title
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                    width: maxWidth,
                    child: LabelMediumGreyText(
                      text: data['SUBTITLE'],
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
