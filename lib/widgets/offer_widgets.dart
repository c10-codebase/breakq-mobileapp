import 'package:breakq/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class OfferTextGreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kPaddingS),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(color: Colors.green.withOpacity(0.5), width: 1.0)),
      child: Text(
        "35% OFF",
        style: Theme.of(context).textTheme.caption.fs8.green.w800,
      ),
    );
  }
}