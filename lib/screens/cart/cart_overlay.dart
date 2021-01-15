import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/cart/cart_page.dart';
import 'package:breakq/screens/scan/barcode_scanner.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HybridFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        buildWhen: (previous, current) => current is CartLoaded,
        builder: (context, state) {
          if (state is CartLoaded) {
            if (state.hide) return Container();
            if (state.cart.cartItems?.isNotEmpty ?? false)
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ScanFloatingButton(),
                  CartButton(
                    totalItems: state.cart.noOfProducts,
                    cartValue: state.cart.cartValue,
                  ),
                ],
              );
          }
          return ScanFloatingButtonExtended();
        });
  }
}

class CartButton extends StatelessWidget {
  CartButton({this.totalItems, this.cartValue});
  final int totalItems;
  final double cartValue;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => getIt.get<AppGlobals>().showCartPage(context),
      heroTag: null,
      label: Container(
        width: 160.0,
        child: Row(
          children: [
            Spacer(flex: 3),
            Image(height: 25, image: AssetImage(AssetImages.cart)),
            Spacer(),
            BoldTitle(title: '( $totalItems )'),
            Spacer(),
            BoldTitle(title: '₹ ${(cartValue).toStringAsFixed(2)}'),
            // Spacer(),
            // CircleButton(),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

class ScanFloatingButtonExtended extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        heroTag: null,
        backgroundColor: Colors.black,
        onPressed: () => BarcodeScanner().scan(context),
        // onPressed: () => Navigator.pushNamed(context, Routes.scan),
        label: Padding(
          padding: const EdgeInsets.all(kPaddingS),
          child: Row(
            children: [
              Text('Scan',
                  style: Theme.of(context).textTheme.bodyText1.bold.white),
              SizedBox(width: kPaddingM),
              Image(
                image: AssetImage(AssetImages.scan),
                color: Colors.white,
              ),
            ],
          ),
        ));
  }
}

class ScanFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
          heroTag: null,
          backgroundColor: Colors.black,
          onPressed: () => BarcodeScanner().scan(context),
          // onPressed: () => Navigator.pushNamed(context, Routes.scan),
          child: Image(
            image: AssetImage(AssetImages.scan),
            color: Colors.white,
          )),
    );
  }
}

class CircleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kWhite,
      radius: 12,
      child: Icon(Icons.arrow_drop_up_outlined),
    );
  }
}
