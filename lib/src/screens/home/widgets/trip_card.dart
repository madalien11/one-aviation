import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/text_styles.dart';

class TripCard extends StatelessWidget {
  const TripCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 224,
      width: 140,
      margin: const EdgeInsets.only(right: 14, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
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
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            'London, UK',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: MyTextStyle.googleFontWrapper(
                              MyTextStyle.CardTitleTextStyle,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            ' \$4.2k',
                            overflow: TextOverflow.ellipsis,
                            style: MyTextStyle.googleFontWrapper(
                              MyTextStyle.CardTitleTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        RotationTransition(
                          turns: AlwaysStoppedAnimation(30 / 360),
                          child: Icon(
                            Icons.navigation_rounded,
                            size: 12,
                          ),
                        ),
                        SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            '12 Days Trip',
                            overflow: TextOverflow.ellipsis,
                            style: MyTextStyle.googleFontWrapper(
                              MyTextStyle.CardSubtitleTextStyle,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
