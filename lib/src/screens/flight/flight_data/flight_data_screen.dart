import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_aviation/src/common/utils/date_formater.dart';
import 'package:one_aviation/src/common/widgets/buttons/pink_rounded_button.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';
import 'package:one_aviation/src/models/search_flight/found_flight_model.dart';
import 'package:one_aviation/src/screens/profile/my_orders/widgets/one_direction_data.dart';

class FlightDataScreen extends StatefulWidget {
  FlightDataScreen({
    required this.foundFlightModel,
    required this.isFromHomeScreen,
  });
  final FoundFlightModel foundFlightModel;
  final bool isFromHomeScreen;

  @override
  _FlightDataScreenState createState() => _FlightDataScreenState();
}

class _FlightDataScreenState extends State<FlightDataScreen> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Stack(
                children: [
                  SizedBox(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://images.pexels.com/photos/1662312/pexels-photo-1662312.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) => Icon(
                        CupertinoIcons.exclamationmark_octagon,
                        color: PrimaryOrangeColor,
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.6,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 25,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            widget.foundFlightModel.to.name,
                            style: seaplanesTitleTextStyle,
                          ),
                          Text(
                            "€${widget.foundFlightModel.price}",
                            style: MyTextStyle.googleFontWrapper(
                              MyTextStyle.SeaplanesSubtitleTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6 + 40,
                  ),
                ],
              ),
              Padding(
                padding: paddingHorizontal40,
                child: Column(
                  children: [
                    OneDirectionData(foundFlightModel: widget.foundFlightModel),
                    SizedBox(height: 20),
                    FlightDataWidget(
                      title: 'From',
                      data: widget.foundFlightModel.from.name,
                    ),
                    SizedBox(height: 12),
                    FlightDataWidget(
                      title: 'Departure Time',
                      data: dateFormatter(
                        widget.foundFlightModel.departureTime,
                        hasTime: true,
                      ),
                    ),
                    SizedBox(height: 12),
                    FlightDataWidget(
                      title: 'To',
                      data: widget.foundFlightModel.to.name,
                    ),
                    SizedBox(height: 12),
                    FlightDataWidget(
                      title: 'Arrival Time',
                      data: dateFormatter(
                        widget.foundFlightModel.arrivalTime,
                        hasTime: true,
                      ),
                    ),
                    SizedBox(height: 12),
                    FlightDataWidget(
                      title: 'Journey duration',
                      data: timeDurationFormatter(
                        DateTime(0).add(
                          widget.foundFlightModel.arrivalTime.difference(
                            widget.foundFlightModel.departureTime,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    PinkRoundedButton(
                      title: 'BOOK NOW',
                      onTap: _isPressed
                          ? null
                          : () {
                              setState(() => _isPressed = true);

                              Navigator.pushNamed(
                                context,
                                widget.isFromHomeScreen
                                    ? '/home/passengers'
                                    : '/flight/passengers',
                              );

                              setState(() => _isPressed = false);
                            },
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FlightDataWidget extends StatelessWidget {
  const FlightDataWidget({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: MyTextStyle.googleFontWrapper(
              MyTextStyle.FlightDataBoldTextStyle),
        ),
        Text(
          data,
          style: MyTextStyle.googleFontWrapper(MyTextStyle.FlightDataTextStyle),
        ),
      ],
    );
  }
}
