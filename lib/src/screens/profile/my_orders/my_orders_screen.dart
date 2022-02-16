import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';
import 'package:one_aviation/src/screens/flight/bloc/flights_bloc.dart';

import 'widgets/my_order_card.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FlightsBloc>().add(GetMyHistory());
  }

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
          child: BlocBuilder<FlightsBloc, FlightsState>(
            builder: (context, state) {
              if (state is MyHistoryUnsuccessful) {
                return GestureDetector(
                    onTap: () {
                      context.read<FlightsBloc>().add(GetMyHistory());
                    },
                    child: Center(child: Text(state.errorMessage)));
              } else if (state is MyHistorySuccessful) {
                return ListView.builder(
                  itemBuilder: (context, i) {
                    return MyOrderCard(
                      isMyHistory: true,
                      foundFlightModel: state.myHistory[i],
                    );
                  },
                  itemCount: state.myHistory.length,
                );
              } else {
                return Center(child: CupertinoActivityIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
