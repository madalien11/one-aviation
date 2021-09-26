import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

class HomeScreenImage extends StatelessWidget {
  const HomeScreenImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: CachedNetworkImage(
            imageUrl:
                'https://images.pexels.com/photos/1662312/pexels-photo-1662312.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
            placeholder: (context, url) => CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => Icon(
              CupertinoIcons.exclamationmark_octagon,
              color: PrimaryOrangeColor,
            ),
            fit: BoxFit.cover,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.33,
          ),
        ),
        Positioned(
          top: 10,
          left: 25,
          child: Text(
            'ONE Aviation',
            style: MyTextStyle.googleFontWrapper(
              MyTextStyle.OneAviationTitleTextStyle,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.33,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Seaplanes',
                  style: seaplanesTitleTextStyle,
                ),
                Text(
                  'FIND YOUR ADVENTURE',
                  style: MyTextStyle.googleFontWrapper(
                    MyTextStyle.SeaplanesSubtitleTextStyle,
                  ),
                ),
              ],
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
