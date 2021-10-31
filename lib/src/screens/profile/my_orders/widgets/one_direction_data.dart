import 'package:flutter/material.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

class OneDirectionData extends StatelessWidget {
  const OneDirectionData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 28),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '06:50',
              style: MyTextStyle.googleFontWrapper(
                MyTextStyle.MyOrdersCardTimeTextStyle,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'FLR',
              style: MyTextStyle.googleFontWrapper(
                MyTextStyle.MyOrdersCardCodeTextStyle,
              ),
            ),
          ],
        ),
        SizedBox(width: 23),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '1h 50m',
                style: MyTextStyle.googleFontWrapper(
                  MyTextStyle.MyOrdersCardDurationTextStyle,
                ),
              ),
              Container(
                color: DividerColor,
                height: 2,
                width: double.infinity,
              ),
              Text(
                'Direct',
                style: MyTextStyle.googleFontWrapper(
                  MyTextStyle.MyOrdersCardTypeTextStyle,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        RotationTransition(
          turns: AlwaysStoppedAnimation(90 / 360),
          child: Icon(
            Icons.flight,
            color: PlaceholderGrayColor,
            size: 16,
          ),
        ),
        SizedBox(width: 22),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '06:50',
              style: MyTextStyle.googleFontWrapper(
                MyTextStyle.MyOrdersCardTimeTextStyle,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'FLR',
              style: MyTextStyle.googleFontWrapper(
                MyTextStyle.MyOrdersCardCodeTextStyle,
              ),
            ),
          ],
        ),
        SizedBox(width: 28),
      ],
    );
  }
}
