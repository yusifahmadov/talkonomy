import 'package:flutter/material.dart';
import '../constant.dart';
import '../radius/custom_radius.dart';

import '../../injection.dart';

class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration({required String hintText, Widget? prefixIcon})
      : super(
            hintText: hintText,
            prefixIconConstraints: const BoxConstraints(maxWidth: 50, minWidth: 40),
            prefixIcon: prefixIcon,
            hintStyle: Theme.of(ctx!).textTheme.bodyMedium!.copyWith(color: const Color(0xff676767)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: CustomRadius.size10()),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: redColor, width: 0.7),
              borderRadius: CustomRadius.size10(),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: redColor, width: 0.7),
              borderRadius: CustomRadius.size10(),
            ),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: CustomRadius.size10()),
            filled: true,
            fillColor: const Color(0xffF6F7FB));
}
