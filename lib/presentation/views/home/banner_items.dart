import 'package:flutter/material.dart';
import 'package:online_shopping/token/app_colors.dart';

import '../components/remote_image.dart';
import '../components/text_component.dart';

class BannerItem extends StatelessWidget {
  final String url;
  final String title;

  const BannerItem({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 196.0,
      width: double.infinity,
      child: Stack(
        children: [
          RemoteImage(
              height: 196.0,
              width: double.infinity,
              fit: BoxFit.cover,
              imagePath: url),
          Positioned(
            left: 16.0,
            top: 136.0,
            child: ReusableText(
                text: title,
                textStyle: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: AppColors.whiteColor)),
          )
        ],
      ),
    );
  }
}
