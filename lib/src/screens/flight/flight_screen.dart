import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_aviation/src/common/widgets/buttons/pink_rounded_button.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

import 'widgets/flight_data_input_row.dart';
import 'widgets/flight_screen_image.dart';
import 'widgets/options_buttons.dart';
import 'widgets/radio_buttons.dart';

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

  String from = "From";
  String to = "To";

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
                        });
                      },
                      () {
                        setState(() {
                          _options[0] = false;
                          _options[1] = true;
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
          firstText: from,
          firstIcon: Icons.flight_takeoff_rounded,
          firstTextController: _fromTextController,
          firstChanged: from != 'From',
          firstOnTap: () async {
            var data = await Navigator.pushNamed(context, '/flight/map');
            if (data != null) setState(() => from = data.toString());
          },
          secondText: to,
          secondIcon: Icons.flight_land_rounded,
          secondTextController: _toTextController,
          secondChanged: to != 'To',
          secondOnTap: () async {
            var data = await Navigator.pushNamed(context, '/flight/map');
            if (data != null) setState(() => to = data.toString());
          },
        ),
        if (val == 1)
          FlightDataInputRow(
            title: 'Date',
            firstText: 'Departure',
            firstIcon: Icons.calendar_today_outlined,
            firstTextController: _departureTextController,
            secondText: 'Return',
            secondIcon: Icons.calendar_today_outlined,
            secondTextController: _returnTextController,
          ),
        if (val == 2)
          FlightDataInputRow(
            title: 'Date',
            firstText: 'Departure',
            firstIcon: Icons.calendar_today_outlined,
            firstTextController: _departureTextController,
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
              setState(() {
                checkedValue = newValue ?? false;
              });
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
        SizedBox(height: 10),
        PinkRoundedButton(
          title: isFirst ? 'Search Flights' : 'Continue',
          onTap: () {},
        ),
        SizedBox(height: 60),
      ],
    );
  }
}
