import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:one_aviation/src/common/validator/validators.dart';
import 'package:one_aviation/src/common/widgets/text_fields/flight_info_text_field.dart';
import 'package:one_aviation/src/constants/text_styles.dart';
import 'package:one_aviation/src/screens/flight/add_passengers/add_passengers_screen.dart';
import 'package:one_aviation/src/screens/flight/widgets/radio_buttons.dart';

// GlobalKey<FormState> passengerInfoFormkey = GlobalKey<FormState>();

class PassengerDataTextField extends StatefulWidget {
  const PassengerDataTextField({
    Key? key,
    required this.number,
    required this.title,
    required this.nameTextController,
    required this.surnameTextController,
    required this.emailTextController,
    required this.documentTextController,
    required this.phoneTextController,
    required this.passengerInfoFormkey,
    required this.onChanged,
  }) : super(key: key);

  final int number;
  final String title;
  final TextEditingController nameTextController;
  final TextEditingController surnameTextController;
  final TextEditingController emailTextController;
  final TextEditingController documentTextController;
  final TextEditingController phoneTextController;
  final GlobalKey<FormState> passengerInfoFormkey;
  final Function onChanged;

  @override
  State<PassengerDataTextField> createState() => _PassengerDataTextFieldState();
}

class _PassengerDataTextFieldState extends State<PassengerDataTextField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.passengerInfoFormkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            widget.title,
            style: MyTextStyle.googleFontWrapper(
              MyTextStyle.SmallerTitleTextStyle,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: FlightInfoTextField(
                  hintText: 'First Name',
                  controller: widget.nameTextController,
                  icon: Icons.person,
                  keyboardType: TextInputType.text,
                ),
              ),
              Spacer(),
              Expanded(
                flex: 3,
                child: FlightInfoTextField(
                  hintText: 'Last Name',
                  controller: widget.surnameTextController,
                  icon: Icons.person,
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
          FlightInfoTextField(
            hintText: 'Email',
            controller: widget.emailTextController,
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: MultiValidator([
              requiredValidator,
              emailValidator,
            ]),
          ),
          RadioButtons(
            val: documents[widget.number - 1],
            firstOption: 'Passport',
            secondOption: 'National ID',
            onChanged: (int? value) {
              widget.onChanged(value);
              setState(() {});
            },
          ),
          FlightInfoTextField(
            hintText: 'Document ID',
            controller: widget.documentTextController,
            icon: Icons.person_pin,
            keyboardType: TextInputType.number,
          ),
          FlightInfoTextField(
            hintText: 'Phone number',
            controller: widget.phoneTextController,
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            validator: MultiValidator([
              requiredValidator,
              phoneValidator,
            ]),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
