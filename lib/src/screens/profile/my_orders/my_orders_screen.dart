import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';
import 'package:one_aviation/src/models/location_coords_model.dart';
import 'package:one_aviation/src/models/search_flight/found_flight_model.dart';

import 'widgets/my_order_card.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: MyTextStyle.googleFontWrapper(
            MyTextStyle.AppBarTextStyle,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: AppBarTextColor,
          ),
        ),
        backgroundColor: AppBarBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: paddingAll20,
          child: ListView.builder(
            itemBuilder: (context, i) {
              return MyOrderCard(
                foundFlightModel: FoundFlightModel(
                  id: 69,
                  departureTime: DateTime.now(),
                  arrivalTime: DateTime.now().add(
                    Duration(hours: 3, minutes: 15),
                  ),
                  availableSeats: 3,
                  price: '2500',
                  from: LocationCoordsModel(
                    latitude: 44.093484,
                    longitude: 11.495894,
                  ),
                  to: LocationCoordsModel(
                    latitude: 42.395839,
                    longitude: 12.093458,
                  ),
                  status: 'Active',
                ),
                fromPortName: 'FLR',
                toPortName: 'CDG',
              );
            },
            itemCount: 5,
          ),
        ),
      ),
    );
  }
}
