import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant.dart';

import '../radius/custom_radius.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color? buttonColor;
  final String text;
  final TextStyle? textStyle;
  const CustomButton({super.key, required this.onPressed, this.buttonColor, required this.text, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 44.sp,
      onPressed: onPressed,
      color: buttonColor ?? appPrimaryColor,
      shape: RoundedRectangleBorder(borderRadius: CustomRadius.size10()),
      child: Center(
        child: Text(
          text,
          style: textStyle ?? Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
