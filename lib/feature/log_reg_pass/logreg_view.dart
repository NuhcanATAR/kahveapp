import 'package:flutter/material.dart';
import 'package:kahve/feature/log_reg_pass/widget/centerbody_widget.dart';
import 'package:kahve/feature/log_reg_pass/widget/topbody_widget.dart';
import 'package:kahve/product/utility/base/log_reg_pass_base/logreg_base/logreg_base.dart';

class LogRegView extends StatefulWidget {
  const LogRegView({super.key});

  @override
  State<LogRegView> createState() => _LogRegViewState();
}

class _LogRegViewState extends MainLogRegBase<LogRegView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: maxWidth,
        height: maxHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // top body
            buildTopBodyWidget,
            // center body
            buildCenterBodyWidget,
          ],
        ),
      ),
    );
  }

  // top body
  Widget get buildTopBodyWidget => TopBodyWidget(
        maxWidth: maxWidth,
        dynamicHeight: dynamicHeight,
      );

  // center body
  Widget get buildCenterBodyWidget => CenterBodyWidget(
        maxWidth: maxWidth,
        dynamicHeight: dynamicHeight,
        routerService: routerService,
      );
}
