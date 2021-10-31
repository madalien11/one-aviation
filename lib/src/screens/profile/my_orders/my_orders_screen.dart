import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

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
              return MyOrderCard();
            },
            itemCount: 5,
          ),
        ),
      ),
    );
  }
}
