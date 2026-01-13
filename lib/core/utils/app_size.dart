


import 'package:flutter/material.dart';

class AppSize {
  static double screenWidth(BuildContext context, double percentage) =>
      MediaQuery.sizeOf(context).width / percentage;
  static double screenHeight(BuildContext context, double percentage) =>
      MediaQuery.sizeOf(context).height / percentage;

  static Widget sizedBox({bool? isHeight = false, required double size}) {
    return SizedBox(
      height: isHeight == true ? size : null,
      width: isHeight == false ? size : null,
    );
  }
}
