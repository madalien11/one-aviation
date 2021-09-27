import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

import 'widgets/home_screen_image.dart';
import 'widgets/location_search_widget.dart';
import 'widgets/trip_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Stack(
                children: [
                  HomeScreenImage(),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.33 - 45,
                    left: 20,
                    right: 20,
                    child: LocationSearchWidget(),
                  ),
                ],
              ),
              Padding(
                padding: paddingHorizontal21,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top Destinations',
                      style: MyTextStyle.googleFontWrapper(
                        MyTextStyle.TitleTextStyle,
                      ),
                    ),
                    SizedBox(height: 27),
                    SizedBox(
                      height: 244,
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: ClampingScrollPhysics(),
                        itemCount: 8,
                        itemBuilder: (context, i) {
                          return TripCard();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
