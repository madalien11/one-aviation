import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_aviation/src/common/utils/date_formater.dart';
import 'package:one_aviation/src/common/utils/date_time_picker.dart';
import 'package:one_aviation/src/common/widgets/buttons/pink_rounded_button.dart';
import 'package:one_aviation/src/common/widgets/text/error_message.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';
import 'package:one_aviation/src/models/location_coords_model.dart';
import 'package:one_aviation/src/models/ports/port_location_model.dart';
import 'package:one_aviation/src/models/search_flight/search_flight_model.dart';

import 'widgets/flight_data_input_row.dart';
import 'widgets/flight_screen_image.dart';
import 'widgets/options_buttons.dart';
import 'widgets/radio_buttons.dart';

SearchFlightModel? globalSearchFlightData;
String fromPortName = "From";
String toPortName = "To";

class FlightScreen extends StatefulWidget {
  @override
  _FlightScreenState createState() => _FlightScreenState();
}

class _FlightScreenState extends State<FlightScreen> {
  List<bool> _options = [true, false];
  int val = 1;
  final _fromTextController = TextEditingController();
  final _toTextController = TextEditingController();
  final _departureTextController = TextEditingController();
  final _returnTextController = TextEditingController();
  final _passengersTextController = TextEditingController();
  bool checkedValue = false;

  PortLocaitonModel? fromPort;
  PortLocaitonModel? toPort;

  String departure = "Departure";
  String returnDate = "Return";

  bool _showError = false;
  String _errorMessage = 'Fill in all the fields';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                FlightScreenImage(),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.33 - 70,
                  left: 20,
                  right: 20,
                  child: OptionsButtons(
                    options: _options,
                    functions: [
                      () {
                        setState(() {
                          _options[0] = true;
                          _options[1] = false;
                          departure = "Departure";
                          returnDate = "Return";
                          FocusScope.of(context).unfocus();
                        });
                      },
                      () {
                        setState(() {
                          _options[0] = false;
                          _options[1] = true;
                          departure = "Departure";
                          returnDate = "Return";
                          FocusScope.of(context).unfocus();
                        });
                      },
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.33,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.67 - 40,
                    padding: paddingHorizontal40,
                    decoration: BoxDecoration(
                      color: ContainerBackgroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Flight Information',
                            textAlign: TextAlign.center,
                            style: MyTextStyle.googleFontWrapper(
                              MyTextStyle.TitleTextStyle,
                            ),
                          ),
                          SizedBox(height: 10),
                          if (_options[0]) page(true),
                          if (_options[1]) page(false),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column page(bool isFirst) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RadioButtons(
          val: val,
          onChanged: (int? value) {
            setState(() => val = value!);
          },
        ),
        FlightDataInputRow(
          title: 'Location',
          firstText: fromPortName,
          firstIcon: Icons.flight_takeoff_rounded,
          firstTextController: _fromTextController,
          firstChanged: fromPortName != 'From',
          firstOnTap: () async {
            dynamic data = await Navigator.pushNamed(context, '/flight/map')
                as PortLocaitonModel;
            if (data != null)
              setState(() {
                fromPortName = data.name.toString();
                fromPort = data;
              });
          },
          secondText: toPortName,
          secondIcon: Icons.flight_land_rounded,
          secondTextController: _toTextController,
          secondChanged: toPortName != 'To',
          secondOnTap: () async {
            dynamic data = await Navigator.pushNamed(context, '/flight/map')
                as PortLocaitonModel;
            if (data != null)
              setState(() {
                toPortName = data.name.toString();
                toPort = data;
              });
          },
        ),
        if (val == 1)
          FlightDataInputRow(
              title: 'Date',
              firstText: departure != 'Departure'
                  ? dateFormatter(DateTime.parse(departure))
                  : departure,
              firstIcon: Icons.calendar_today_outlined,
              firstTextController: _departureTextController,
              firstChanged: departure != 'Departure',
              firstOnTap: () async {
                String res = await dateTimePicker(
                  context,
                  departure,
                  isSearch: isFirst,
                );
                setState(() => departure = res);
              },
              secondText: returnDate != 'Return'
                  ? dateFormatter(DateTime.parse(returnDate))
                  : returnDate,
              secondIcon: Icons.calendar_today_outlined,
              secondTextController: _returnTextController,
              secondChanged: returnDate != 'Return',
              secondOnTap: () async {
                String res = await dateTimePicker(
                  context,
                  departure,
                  isDeparture: false,
                  isSearch: isFirst,
                );
                setState(() => returnDate = res);
              }),
        if (val == 2)
          FlightDataInputRow(
            title: 'Date',
            firstText: departure != 'Departure'
                ? dateFormatter(DateTime.parse(departure))
                : departure,
            firstIcon: Icons.calendar_today_outlined,
            firstTextController: _departureTextController,
            firstChanged: departure != 'Departure',
            firstOnTap: () async {
              String res = await dateTimePicker(
                context,
                departure,
                isSearch: isFirst,
              );
              setState(() => departure = res);
            },
          ),
        if (isFirst)
          FlightDataInputRow(
            title: 'Passengers',
            firstText: 'Passengers',
            firstIcon: Icons.person,
            firstTextController: _passengersTextController,
          ),
        SizedBox(height: 10),
        if (!isFirst)
          CheckboxListTile(
            title: Text("Make the flight shareable"),
            checkColor: WhiteTitleTextColor,
            activeColor: PrimaryDarkTextColor,
            value: checkedValue,
            onChanged: (newValue) {
              setState(() => checkedValue = newValue ?? false);
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
        _showError ? ErrorMessage(errorMessage: _errorMessage) : SizedBox(),
        SizedBox(height: 10),
        PinkRoundedButton(
          title: isFirst ? 'Search Flights' : 'Continue',
          onTap: isFirst
              ? () {
                  int? nums = int.tryParse(_passengersTextController.text);
                  if (nums != null && nums <= 8) {
                    if (((val == 1 && returnDate != "Return") || (val == 2)) &&
                        departure != "Departure" &&
                        toPort != null &&
                        fromPort != null) {
                      FocusScope.of(context).unfocus();
                      setState(() => _showError = false);

                      globalSearchFlightData = SearchFlightModel(
                        dateFrom: DateTime.parse(departure),
                        dateTo: returnDate != "Return"
                            ? DateTime.parse(returnDate)
                            : null,
                        locationFrom: LocationCoordsModel(
                          latitude: fromPort!.latitude,
                          longitude: fromPort!.longitude,
                        ),
                        locationTo: LocationCoordsModel(
                          latitude: toPort!.latitude,
                          longitude: toPort!.longitude,
                        ),
                        numberOfPassengers: nums,
                      );
                      Navigator.pushNamed(context, '/flight/search');
                    } else {
                      setState(() {
                        _showError = true;
                        _errorMessage = 'Fill in all the fields';
                      });
                    }
                  } else {
                    setState(() {
                      _showError = true;
                      _errorMessage = "Number of passengers can't exceed 8";
                    });
                  }
                }
              : () {},
        ),
        SizedBox(height: 60),
      ],
    );
  }
}
