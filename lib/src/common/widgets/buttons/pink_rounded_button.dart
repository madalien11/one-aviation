import 'package:flutter/material.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

class PinkRoundedButton extends StatelessWidget {
  const PinkRoundedButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: PrimaryPinkColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onTap as Function()?,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: MyTextStyle.googleFontWrapper(
              MyTextStyle.ButtonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
