import 'package:flutter/material.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

class OptionsButtons extends StatefulWidget {
  const OptionsButtons({
    Key? key,
    required this.options,
    required this.functions,
  }) : super(key: key);

  final List<bool> options;
  final List<Function> functions;

  @override
  _OptionsButtonsState createState() => _OptionsButtonsState();
}

class _OptionsButtonsState extends State<OptionsButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            TextButton(
              onPressed: widget.functions[0] as Function(),
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
              ),
              child: Text(
                'Discover flights',
                style: MyTextStyle.googleFontWrapper(
                  MyTextStyle.UnderscoredTextButtonTextStyle,
                ),
              ),
            ),
            if (widget.options[0])
              Container(
                height: 1,
                width: 100,
                color: Colors.white,
              ),
          ],
        ),
        Column(
          children: [
            TextButton(
              onPressed: widget.functions[1] as Function(),
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
              ),
              child: Text(
                'Create a flight',
                style: MyTextStyle.googleFontWrapper(
                  MyTextStyle.UnderscoredTextButtonTextStyle,
                ),
              ),
            ),
            if (widget.options[1])
              Container(
                height: 1,
                width: 100,
                color: Colors.white,
              ),
          ],
        ),
      ],
    );
  }
}
