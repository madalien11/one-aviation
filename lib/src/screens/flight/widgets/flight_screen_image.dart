import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

class FlightScreenImage extends StatelessWidget {
  const FlightScreenImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: Image.asset(
            'assets/images/world_map.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.33 + 30,
          ),
        ),
        Container(
          color: PrimaryBlueColor.withOpacity(0.7),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.33 + 30,
        ),
        Positioned(
          top: 10,
          left: 25,
          child: Text(
            'ONE Aviation',
            style: MyTextStyle.googleFontWrapper(
              MyTextStyle.OneAviationTitleTextStyle.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.33 + 90,
        ),
      ],
    );
  }
}
