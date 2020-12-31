import 'package:breakq/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class TopDealsCard extends StatelessWidget {
  TopDealsCard({this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Card(
        // shape: RoundedRectangleBorder(),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image(
                  image: AssetImage(categories[index]['image']),
                  fit: BoxFit.fill),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(categories[index]['name'],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2.bold),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}