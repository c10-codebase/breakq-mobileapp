import 'package:breakq/configs/constants.dart';
import 'package:breakq/screens/orders/widgets/invoice_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Invoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Invoice"),
          leading: IconButton(
              icon: Icon(Feather.arrow_left_circle),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          child: Column(
            children: [
              InvoiceHeader(),
              InvoiceThanksForShopping(),
              Container(color: kWhite, child: Divider(thickness: 2)),
              InvoiceBillDetails(),
              Container(color: kWhite, child: Divider(thickness: 2)),
              SizedBox(height: kPaddingM * 2),
              InvoiceBillItems(
                products: generateSampleProducts(),
              ),
              SizedBox(height: kPaddingM * 2),
              InvoicePriceDetails(price: generateSamplePrice()),
              SizedBox(height: kPaddingL),
              InvoiceQRCode(billNo: '1234567890'),
            ],
          ),
        ));
  }
}