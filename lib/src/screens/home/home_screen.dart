import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';
import 'package:one_aviation/src/models/search_flight/found_flight_model.dart';
import 'package:one_aviation/src/screens/flight/bloc/flights_bloc.dart';
import 'package:one_aviation/src/screens/profile/my_orders/widgets/my_order_card.dart';

import 'widgets/home_screen_image.dart';
import 'widgets/location_search_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _errorMessage = "No flights were found";
  bool _showError = false;
  bool _isLoading = true;

  List<FoundFlightModel> foundFlights = [];

  @override
  void initState() {
    super.initState();
    context.read<FlightsBloc>().add(SearchFlights());
  }

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
              BlocListener<FlightsBloc, FlightsState>(
                listener: (context, state) {
                  if (state is SearchFlightsLoading) {
                    setState(() => _isLoading = true);
                  } else {
                    setState(() => _isLoading = false);
                  }

                  if (state is SearchFlightsSuccessful) {
                    setState(() {
                      _showError = false;
                      foundFlights.clear();
                      foundFlights = state.foundFlights;
                    });
                  } else if (state is SearchFlightsUnsuccessful) {
                    setState(() {
                      _showError = true;
                      _errorMessage = state.errorMessage;
                    });
                  }
                },
                child: _isLoading
                    ? Center(child: CupertinoActivityIndicator())
                    : _showError
                        ? GestureDetector(
                            onTap: () {
                              setState(() => _showError = false);
                            },
                            child: Center(child: Text(_errorMessage)))
                        : Padding(
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
                                ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: foundFlights.length + 1,
                                  itemBuilder: (context, i) =>
                                      i == foundFlights.length
                                          ? SizedBox(height: 40)
                                          : MyOrderCard(
                                              isFromHomeScreen: true,
                                              foundFlightModel: foundFlights[i],
                                            ),
                                ),
                              ],
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
