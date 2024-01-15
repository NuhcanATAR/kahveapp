import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/utility/base/main_view_base/home_base/home_base.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kahve/product/widget/text_widget/title_medium_text.dart';

class BlogDetailView extends StatefulWidget {
  const BlogDetailView({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  State<BlogDetailView> createState() => _BlogDetailViewState();
}

class _BlogDetailViewState extends MainHomeBaseState<BlogDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: const LabelMediumWhiteText(
          text: "Blog Detayı",
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // cover ımg
            buildCoverImg(context, widget.data),
            // date
            buildDate(context, widget.data),
            // author
            buildAuthor(context, widget.data),
            // title
            buildTitleWidget(context, widget.data),
            // sub title
            buildSubTitleWidget(context, widget.data),
            // explanation
            buildExplanation(context, widget.data),
          ],
        ),
      ),
    );
  }

  // cover img
  Widget buildCoverImg(context, data) => SizedBox(
        width: maxWidth,
        height: dynamicHeight(0.5),
        child: CachedNetworkImage(
          imageUrl: widget.data['IMG'],
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black54.withOpacity(0.4), BlendMode.colorBurn),
              ),
            ),
          ),
        ),
      );

  // date
  Widget buildDate(context, data) => Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.date_range_outlined,
              color: ColorBackgroundConstant.greenDarker,
              size: 18,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: LabelMediumBlackText(
                  text:
                      "${widget.data['DAY'].toString()}/${widget.data['MONTH'].toString()}/${widget.data['YEAR'].toString()}",
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      );

  // author
  Widget buildAuthor(context, data) => Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.account_circle_outlined,
              color: ColorBackgroundConstant.greenDarker,
              size: 18,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: LabelMediumBlackText(
                  text: "Yazar: ${widget.data['AUTHOR'].toString()}",
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      );

  // title
  Widget buildTitleWidget(context, data) => Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: SizedBox(
          width: maxWidth,
          child: TitleMediumBlackBoldText(
            text: widget.data['TITLE'],
            textAlign: TextAlign.left,
          ),
        ),
      );

  // sub title
  Widget buildSubTitleWidget(context, data) => Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: SizedBox(
          width: maxWidth,
          child: LabelMediumGreyText(
            text: widget.data['SUBTITLE'],
            textAlign: TextAlign.left,
          ),
        ),
      );

  // explanation
  Widget buildExplanation(context, data) => Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: SizedBox(
          width: maxWidth,
          child: LabelMediumBlackText(
            text: widget.data['EXPLANATION'],
            textAlign: TextAlign.left,
          ),
        ),
      );
}
