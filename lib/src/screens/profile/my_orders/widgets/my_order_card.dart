import 'package:flutter/material.dart';
import 'package:one_aviation/src/common/utils/price_formatter.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/text_styles.dart';
import 'package:one_aviation/src/models/search_flight/found_flight_model.dart';

import 'one_direction_data.dart';

late int foundFlightId;

class MyOrderCard extends StatelessWidget {
  const MyOrderCard({
    Key? key,
    required this.foundFlightModel,
    this.isFromHomeScreen = false,
  }) : super(key: key);

  final FoundFlightModel foundFlightModel;
  final bool isFromHomeScreen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        foundFlightId = foundFlightModel.id;
        Navigator.pushNamed(
          context,
          isFromHomeScreen ? '/home/passengers' : '/flight/passengers',
        );
      },
      child: Container(
        height: 150,
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
              child: OneDirectionData(foundFlightModel: foundFlightModel),
            ),
            Expanded(
              child: Row(
                children: [
                  Spacer(),
                  Text(
                    priceFormatter(foundFlightModel.price),
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
      ),
    );
  }
}
