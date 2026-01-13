import 'package:flutter/material.dart';

import 'package:machine_test_quadleo/core/app_theme/app_colors.dart';
import 'package:machine_test_quadleo/core/utils/app_size.dart';

class CommonButton extends StatelessWidget {
  final void Function()? onTap;
  final double? width;
  final bool? isWhite;
  final String buttonText;
  const CommonButton({
    super.key,
    required this.onTap,
    this.width,
    required this.buttonText,
    this.isWhite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? AppSize.screenWidth(context, 1),
        height: 60,
        decoration: BoxDecoration(
          border: isWhite==true?Border.all(color: const Color.fromARGB(255, 237, 236, 236)):null,
          color: isWhite == true ?  Color(0XFFF5F5F5) : AppColors.primaryColor,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Center(
          child: Text(
           buttonText ,
            style: TextStyle(
              color: isWhite == true ? AppColors.black : Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
