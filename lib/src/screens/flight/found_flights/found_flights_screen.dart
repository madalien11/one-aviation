import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/models/search_flight/found_flight_model.dart';
import 'package:one_aviation/src/screens/flight/bloc/flights_bloc.dart';
import 'package:one_aviation/src/screens/flight/flight_screen.dart';
import 'package:one_aviation/src/screens/profile/my_orders/widgets/my_order_card.dart';

import 'widgets/found_flights_screen_image.dart';

class FoundFlightsScreen extends StatefulWidget {
  @override
  _FoundFlightsScreenState createState() => _FoundFlightsScreenState();
}

class _FoundFlightsScreenState extends State<FoundFlightsScreen> {
  String _errorMessage = "Flights were not found";
  bool _showError = false;
  bool _isLoading = true;

  List<FoundFlightModel> foundFlights = [];

  @override
  void initState() {
    super.initState();
    if (globalSearchFlightData != null) {
      context.read<FlightsBloc>().add(SearchFlights(
            searchFlightData: globalSearchFlightData!,
          ));
    } else {
      _errorMessage = "Something went wrong. Try again!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocListener<FlightsBloc, FlightsState>(
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
          child: SafeArea(
            child: _isLoading
                ? Center(child: CupertinoActivityIndicator())
                : _showError
                    ? GestureDetector(
                        onTap: () {
                          setState(() => _showError = false);
                        },
                        child: Center(child: Text(_errorMessage)))
                    : ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: [
                          FoundFlightsScreenImage(
                            searchFlightData: globalSearchFlightData!,
                            fromPortName: fromPortName,
                            toPortName: toPortName,
                          ),
                          Padding(
                            padding: paddingHorizontal21,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                              foundFlightModel: foundFlights[i],
                                              fromPortName: fromPortName,
                                              toPortName: toPortName,
                                            ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
