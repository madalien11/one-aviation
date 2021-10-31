import 'package:flutter/material.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

import 'one_direction_data.dart';

class MyOrderCard extends StatelessWidget {
  const MyOrderCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: MyOrderCardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: OneDirectionData(),
          ),
          Expanded(
            flex: 2,
            child: OneDirectionData(),
          ),
          Expanded(
            child: Row(
              children: [
                Spacer(),
                Text(
                  '€ 1000',
                  style: MyTextStyle.googleFontWrapper(
                    MyTextStyle.MyOrdersCardPriceTextStyle,
                  ),
                ),
                SizedBox(width: 28),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
