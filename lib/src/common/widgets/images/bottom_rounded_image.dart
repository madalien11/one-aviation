import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_aviation/src/constants/colors.dart';

class BottomRoundedImage extends StatelessWidget {
  const BottomRoundedImage({
    Key? key,
    this.imageUrl =
        'https://images.pexels.com/photos/1731440/pexels-photo-1731440.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  }) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(40),
        bottomLeft: Radius.circular(40),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => CupertinoActivityIndicator(),
        errorWidget: (context, url, error) => Icon(
          CupertinoIcons.exclamationmark_octagon,
          color: PrimaryOrangeColor,
        ),
        fit: BoxFit.fitWidth,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.3,
      ),
    );
  }
}
