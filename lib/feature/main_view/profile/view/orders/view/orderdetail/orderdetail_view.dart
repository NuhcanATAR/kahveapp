import 'package:flutter/material.dart';
import 'package:kahve/feature/main_view/profile/view/orders/view/orderdetail/widget/orderdeliveredadresscard_widget.dart';
import 'package:kahve/feature/main_view/profile/view/orders/view/orderdetail/widget/orderinformation_widget.dart';
import 'package:kahve/feature/main_view/profile/view/orders/view/orderdetail/widget/orderpaymentinformationcard_widget.dart';
import 'package:kahve/feature/main_view/profile/view/orders/view/orderdetail/widget/orderproductslist_widget.dart';
import 'package:kahve/feature/main_view/profile/view/orders/view/orderdetail/widget/orderstatusbar_widget.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/utility/base/main_view_base/order_base/order_base.dart';
import 'package:kahve/product/widget/text_widget/label_medium_text.dart';
import 'package:kartal/kartal.dart';

class OrderDetailView extends StatefulWidget {
  const OrderDetailView({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends MainOrderBase<OrderDetailView> {
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
          text: "Sipariş Detayı",
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: context.padding.low,
        child: ListView(
          children: <Widget>[
            // order status widget
            buildOrderStatusWidget(context, widget.data),
            // order information card
            buildOrderInformationCardWidget(context, widget.data),
            // order products list
            buildOrderProductsListWidget(context, widget.data),
            // order delivery adress
            buildOrderDeliveryAdressWidget(context, widget.data),
            // order payment information
            buildOrderPaymentInformationWidget(context, widget.data),
          ],
        ),
      ),
    );
  }

  // order status widget
  Widget buildOrderStatusWidget(context, data) => OrderStatusBarWidget(
        data: data,
        maxWidth: maxWidth,
        dynamicHeight: dynamicHeight,
      );

  // order information card
  Widget buildOrderInformationCardWidget(context, data) =>
      OrderInformationCardWidget(
        data: data,
      );

  // order products list
  Widget buildOrderProductsListWidget(context, data) => OrderProductListWidget(
        data: data,
        maxWidth: maxWidth,
        dynamicHeight: dynamicHeight,
      );

  // order delivery adress
  Widget buildOrderDeliveryAdressWidget(context, data) =>
      OrderDeliveredAdressCardWidget(
        data: data,
        maxWidth: maxWidth,
      );

  // order payment information
  Widget buildOrderPaymentInformationWidget(context, data) =>
      OrderPaymentInformationCardWidget(
        data: data,
        maxWidth: maxWidth,
      );
}
