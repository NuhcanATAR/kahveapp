import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/profile/view/orders/view/ordercontrol/noorder_view.dart';
import 'package:kahve/feature/main_view/profile/view/orders/view/ordercontrol/ordererror_view.dart';
import 'package:kahve/feature/main_view/profile/view/orders/view/ordercontrol/orderloading_view.dart';
import 'package:kahve/feature/main_view/profile/view/orders/widget/productcard_widget.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/enums/order_enums.dart';
import 'package:kahve/product/utility/base/main_view_base/order_base/order_base.dart';
import 'package:kahve/product/utility/database/order_db/order_db.dart';
import 'package:kahve/product/utility/service/firebase_service.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends MainOrderBase<OrdersView> {
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
          text: "Siparişler",
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: context.padding.low,
        child: StreamBuilder<QuerySnapshot>(
          stream: OrderServiceDB.ORDERSETTING.orderSettingList,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return OrderErrorView(
                title: OrderStrings.errorOrderTitleText.value,
                subTitle: OrderStrings.errorOrderSubTitleText.value,
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return OrderLoadingView(
                title: OrderStrings.loadingOrderTitleText.value,
                subTitle: OrderStrings.loadingOrderSubTitleText.value,
              );
            }

            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.docs.isNotEmpty) {
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  if (data['USERIDVALUE'] == FirebaseService().authID) {
                    return OrderProductCardWidget(
                      data: data,
                      maxWidth: maxWidth,
                      dynamicHeight: dynamicHeight,
                      routerService: routerService,
                    );
                  } else {
                    return const SizedBox();
                  }
                }).toList(),
              );
            } else {
              return NoOrderView(
                title: OrderStrings.noOrderTitleText.value,
                subTitle: OrderStrings.noOrderSubTitleText.value,
              );
            }
          },
        ),
      ),
    );
  }
}
