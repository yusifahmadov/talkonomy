import 'package:flutter/material.dart';
import '../../injection.dart';

class CustomTextField extends TextFormField {
  @override
  CustomTextField(
      {super.key,
      required InputDecoration decoration,
      void Function()? onTap,
      void Function(String)? onChanged,
      bool obscureText = false,
      bool readOnly = false,
      TextEditingController? controller,
      String? Function(String?)? validator})
      : super(
            decoration: decoration,
            style: Theme.of(ctx!).textTheme.bodyMedium,
            obscureText: obscureText,
            onChanged: onChanged,
            onTap: onTap,
            readOnly: readOnly,
            controller: controller,
            validator: validator);
}
