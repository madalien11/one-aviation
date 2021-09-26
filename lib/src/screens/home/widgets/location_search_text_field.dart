import 'package:flutter/material.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

class LocationSearchTextField extends StatelessWidget {
  const LocationSearchTextField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        suffix: SizedBox(width: 18),
        hintText: hintText,
        hintStyle: MyTextStyle.googleFontWrapper(
          MyTextStyle.PlaceholderTextStyle,
        ),
        prefixIcon: Icon(
          Icons.location_on_rounded,
          color: PlaceholderIconColor,
        ),
      ),
      style: MyTextStyle.googleFontWrapper(
        MyTextStyle.TextFieldTextStyle,
      ),
    );
  }
}
