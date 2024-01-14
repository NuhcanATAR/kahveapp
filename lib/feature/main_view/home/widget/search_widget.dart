import 'package:flutter/material.dart';
import 'package:kahve/product/enums/home_enums.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget(
      {required this.maxWidth, required this.dynamicHeight, super.key});

  final dynamic maxWidth;
  final dynamic dynamicHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: SizedBox(
        width: maxWidth,
        height: dynamicHeight(0.06),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.search,
                color: Colors.black54,
                size: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: LabelMediumBlackText(
                    text: HomeStrings.searchText.value,
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
}
