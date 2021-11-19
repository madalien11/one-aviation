import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_aviation/src/common/utils/date_formater.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';
import 'package:one_aviation/src/models/search_flight/search_flight_model.dart';

class FoundFlightsScreenImage extends StatelessWidget {
  const FoundFlightsScreenImage({
    Key? key,
    required this.searchFlightData,
    required this.fromPortName,
    required this.toPortName,
  }) : super(key: key);

  final SearchFlightModel searchFlightData;
  final String fromPortName;
  final String toPortName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: CachedNetworkImage(
            imageUrl:
                'https://images.pexels.com/photos/1860626/pexels-photo-1860626.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
            placeholder: (context, url) => CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => Icon(
              CupertinoIcons.exclamationmark_octagon,
              color: PrimaryOrangeColor,
            ),
            fit: BoxFit.cover,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.33,
          ),
        ),
        Positioned(
          top: 10,
          left: 25,
          child: Text(
            'ONE Aviation',
            style: MyTextStyle.googleFontWrapper(
              MyTextStyle.OneAviationTitleTextStyle,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.33,
          child: Center(
            child: Padding(
              padding: paddingHorizontal24,
              child: Row(
                children: [
                  Text(
                    fromPortName,
                    style: MyTextStyle.googleFontWrapper(
                      MyTextStyle.SeaplanesSubtitleTextStyle.copyWith(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(width: 23),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: DividerColor,
                          height: 2,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(90 / 360),
                    child: Icon(
                      Icons.flight,
                      color: DividerColor,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: 22),
                  Text(
                    toPortName,
                    style: MyTextStyle.googleFontWrapper(
                      MyTextStyle.SeaplanesSubtitleTextStyle.copyWith(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 25,
          child: Text(
            searchFlightData.dateTo != null
                ? '${dateFormatter(searchFlightData.dateFrom)} – ${dateFormatter(searchFlightData.dateTo!)}'
                : dateFormatter(searchFlightData.dateFrom),
            style: MyTextStyle.googleFontWrapper(
              MyTextStyle.SeaplanesSubtitleTextStyle,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 25,
          child: Text(
            searchFlightData.numberOfPassengers == 1
                ? '1 Passenger'
                : '${searchFlightData.numberOfPassengers} Passengers',
            style: MyTextStyle.googleFontWrapper(
              MyTextStyle.SeaplanesSubtitleTextStyle,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.33),
      ],
    );
  }
}
