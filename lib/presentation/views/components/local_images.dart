import 'package:flutter/material.dart';

class LocalImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const LocalImage(
      {Key? key, required this.imagePath, this.width, this.height, this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(imagePath),
      width: width,
      height: height,
      fit: fit,
    );
  }
}
