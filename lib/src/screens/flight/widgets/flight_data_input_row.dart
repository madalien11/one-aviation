import 'package:flutter/material.dart';
import 'package:one_aviation/src/common/widgets/text_fields/flight_info_text_field.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

class FlightDataInputRow extends StatelessWidget {
  const FlightDataInputRow({
    Key? key,
    required this.title,
    required this.firstText,
    required this.firstIcon,
    required this.firstTextController,
    this.firstChanged = false,
    this.firstOnTap,
    this.secondText,
    this.secondIcon,
    this.secondTextController,
    this.secondOnTap,
    this.secondChanged = false,
  }) : super(key: key);

  final String title;
  final String firstText;
  final IconData firstIcon;
  final TextEditingController firstTextController;
  final Function? firstOnTap;
  final bool firstChanged;
  final String? secondText;
  final IconData? secondIcon;
  final TextEditingController? secondTextController;
  final Function? secondOnTap;
  final bool secondChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          title,
          style: MyTextStyle.googleFontWrapper(
            MyTextStyle.SmallerTitleTextStyle,
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: FlightInfoTextField(
                onTap: firstOnTap,
                hintText: firstText,
                controller: firstTextController,
                icon: firstIcon,
                changed: firstChanged,
                keyboardType: title == 'Passengers'
                    ? TextInputType.number
                    : TextInputType.text,
              ),
            ),
            Spacer(flex: secondIcon == null ? 3 : 1),
            if (secondIcon != null &&
                secondText != null &&
                secondTextController != null)
              Expanded(
                flex: 2,
                child: FlightInfoTextField(
                  onTap: secondOnTap,
                  hintText: secondText!,
                  controller: secondTextController!,
                  icon: secondIcon!,
                  changed: secondChanged,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
