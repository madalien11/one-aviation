import 'package:flutter/material.dart';
import 'package:one_aviation/src/common/widgets/my_separator.dart';

import 'location_search_text_field.dart';

class LocationSearchWidget extends StatelessWidget {
  const LocationSearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 40,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 44,
            child: LocationSearchTextField(
              hintText: 'Enter your departure city',
            ),
          ),
          SizedBox(
            height: 2,
            child: const MySeparator(),
          ),
          SizedBox(
            height: 44,
            child: LocationSearchTextField(
              hintText: 'Enter your destination city',
            ),
          ),
        ],
      ),
    );
  }
}
