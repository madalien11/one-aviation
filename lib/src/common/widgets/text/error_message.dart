import 'package:flutter/cupertino.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    required this.errorMessage,
    this.color = PrimaryRedColor,
  });
  final String errorMessage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 11,
          bottom: 11,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.exclamationmark_circle_fill,
              color: color,
              size: 20,
            ),
            SizedBox(width: 5),
            Flexible(
              child: Text(
                errorMessage,
                style: MyTextStyle.googleFontWrapper(
                  MyTextStyle.ErrorMessageTextStyle,
                ),
              ),
            ),
          ],
        ));
  }
}
