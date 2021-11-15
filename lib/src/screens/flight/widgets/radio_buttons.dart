import 'package:flutter/material.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

class RadioButtons extends StatefulWidget {
  const RadioButtons({
    Key? key,
    required this.val,
    required this.onChanged,
  }) : super(key: key);

  final int val;
  final Function onChanged;

  @override
  _RadioButtonsState createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtons> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: PrimaryPinkColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Radio(
                value: 1,
                groupValue: widget.val,
                onChanged: (int? i) {
                  widget.onChanged(i);
                },
                activeColor: PrimaryPinkColor,
              ),
              GestureDetector(
                onTap: () {
                  widget.onChanged(1);
                },
                child: Text(
                  "Round Trip",
                  style: MyTextStyle.googleFontWrapper(
                    MyTextStyle.RadioButtonTextStyle,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Radio(
                value: 2,
                groupValue: widget.val,
                onChanged: (int? i) {
                  widget.onChanged(i);
                },
                activeColor: PrimaryPinkColor,
              ),
              GestureDetector(
                onTap: () {
                  widget.onChanged(2);
                },
                child: Text(
                  "One-Way",
                  style: MyTextStyle.googleFontWrapper(
                    MyTextStyle.RadioButtonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
