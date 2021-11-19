import 'package:flutter/material.dart';
import 'package:one_aviation/src/common/utils/date_formater.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/text_styles.dart';
import 'package:one_aviation/src/models/search_flight/found_flight_model.dart';

class OneDirectionData extends StatelessWidget {
  const OneDirectionData({
    Key? key,
    required this.foundFlightModel,
    required this.fromPortName,
    required this.toPortName,
  }) : super(key: key);

  final FoundFlightModel foundFlightModel;
  final String fromPortName;
  final String toPortName;

  @override
  Widget build(BuildContext context) {
    Duration duration =
        foundFlightModel.arrivalTime.difference(foundFlightModel.departureTime);
    print(duration);
    return Row(
      children: [
        SizedBox(width: 28),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timeFormatter(foundFlightModel.departureTime),
              style: MyTextStyle.googleFontWrapper(
                MyTextStyle.MyOrdersCardTimeTextStyle,
              ),
            ),
            SizedBox(height: 4),
            Text(
              fromPortName,
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
                timeDurationFormatter(DateTime(0).add(duration)),
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
              timeFormatter(foundFlightModel.arrivalTime),
              style: MyTextStyle.googleFontWrapper(
                MyTextStyle.MyOrdersCardTimeTextStyle,
              ),
            ),
            SizedBox(height: 4),
            Text(
              toPortName,
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
