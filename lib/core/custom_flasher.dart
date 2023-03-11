import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

import '../injection.dart';
import 'constant.dart';

class CustomFlasher {
  static Future<void> showError(String? text, {onTap}) async {
    showFlash(
        context: ctx!,
        duration: const Duration(seconds: 4),
        builder: (_, controller) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Flash(
              controller: controller,
              alignment: Alignment.topRight,
              backgroundColor: const Color(0xffdc3545),
              boxShadows: kElevationToShadow[2],
              horizontalDismissDirection: HorizontalDismissDirection.horizontal,
              child: InkWell(
                onTap: onTap,
                child: IntrinsicWidth(
                  child: FlashBar(
                    content: Text(
                      text != null ? text.replaceAll("{", "").replaceAll("}", "").replaceAll("detail", "Xəta mesajı") : "Xəta baş verdi!",
                      style: Theme.of(ctx!).textTheme.bodyMedium!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  static void showSuccess(String? text, {onTap}) {
    showFlash(
        context: ctx!,
        duration: const Duration(seconds: 4),
        builder: (_, controller) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Flash(
              controller: controller,
              alignment: Alignment.topRight,
              backgroundColor: greenColor,
              boxShadows: kElevationToShadow[2],
              horizontalDismissDirection: HorizontalDismissDirection.horizontal,
              child: InkWell(
                onTap: onTap,
                child: IntrinsicWidth(
                  child: FlashBar(
                    content: Text(
                      text ?? "Əməliyyat icra olundu!",
                      style: Theme.of(ctx!).textTheme.bodyMedium!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
