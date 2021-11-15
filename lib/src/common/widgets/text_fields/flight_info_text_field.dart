import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

class FlightInfoTextField extends StatelessWidget {
  const FlightInfoTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.onTap,
  }) : super(key: key);

  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: TextFormField(
        onTap: onTap as Function()? ?? () {},
        readOnly: onTap != null,
        controller: controller,
        keyboardType: keyboardType,
        validator:
            MinLengthValidator(0, errorText: "The field cannot be empty"),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: PlaceholderIconColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: PrimaryPinkColor),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: PrimaryRedColor),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: PrimaryRedColor),
          ),
          hintText: hintText,
          hintStyle: MyTextStyle.googleFontWrapper(
            MyTextStyle.PlaceholderTextStyle.copyWith(fontSize: 14),
          ),
          prefixIcon: Icon(
            icon,
            color: PlaceholderIconColor,
            size: 24,
          ),
        ),
        style: MyTextStyle.googleFontWrapper(
          MyTextStyle.TextFieldTextStyle.copyWith(fontSize: 15),
        ),
      ),
    );
  }
}
