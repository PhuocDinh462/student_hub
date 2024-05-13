import 'package:flutter/material.dart';

class ImageList {
  static List<String> images = [
    'assets/images/Coding-workshop.png',
    'assets/images/Hand-coding.png',
    'assets/images/Detailed-analysis.png',
    'assets/images/Fast-loading.png',
  ];

  static void loadImage(BuildContext context) {
    for (var image in images) {
      precacheImage(AssetImage(image), context);
    }
  }
}
