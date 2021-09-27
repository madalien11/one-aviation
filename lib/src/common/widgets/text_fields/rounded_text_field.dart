import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.suffix,
    this.validator,
  }) : super(key: key);
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool isObscure;
  final TextInputType keyboardType;
  final Widget? suffix;
  final MultiValidator? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isObscure,
        validator: validator != null
            ? validator!
            : MinLengthValidator(0, errorText: "The field cannot be empty"),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PrimaryOrangeColor),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PrimaryRedColor),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          suffix: SizedBox(width: 8),
          hintText: hintText,
          hintStyle: MyTextStyle.googleFontWrapper(
            MyTextStyle.PlaceholderTextStyle,
          ),
          prefixIcon: Icon(
            icon,
            color: PlaceholderIconColor,
          ),
          suffixIcon: suffix,
        ),
        style: MyTextStyle.googleFontWrapper(
          MyTextStyle.TextFieldTextStyle,
        ),
      ),
    );
  }
}
