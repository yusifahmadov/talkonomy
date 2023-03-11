import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'use_case/use_case.dart';

import '../injection.dart';
import 'easy_loading/easy_loading.dart';

class UseCaseFetcher {
  static fetch(
      {required Usecase useCase,
      required dynamic model,
      bool goBack = false,
      bool isPopup = false,
      String? savedFieldName,
      required whenSuccess}) async {
    await EasyLoad.show();

    final response = await useCase(model);
    response.fold((l) {
      l != null && l.message != null
          ? showFlash(
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
                    child: IntrinsicWidth(
                      child: FlashBar(
                        content: Text(
                          l.message,
                          style: Theme.of(ctx!).textTheme.bodyMedium!.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              })
          : null;
    }, (r) async {
      EasyLoading.dismiss();

      // showFlash(
      //     context: ctx!,
      //     duration: const Duration(seconds: 4),
      //     builder: (_, controller) {
      //       return Padding(
      //         padding: const EdgeInsets.all(28.0),
      //         child: Flash(
      //           controller: controller,
      //           alignment: Alignment.topRight,
      //           backgroundColor: const Color(0xff1cbb64),
      //           boxShadows: kElevationToShadow[2],
      //           horizontalDismissDirection: HorizontalDismissDirection.horizontal,
      //           child: IntrinsicWidth(
      //             child: FlashBar(
      //               content: Text(
      //                 r != null ? r.detail : "",
      //                 style: Theme.of(ctx!).textTheme.bodyMedium!.copyWith(color: Colors.white),
      //               ),
      //             ),
      //           ),
      //         ),
      //       );
      //     });
      whenSuccess != null ? whenSuccess() : null;
      if (savedFieldName != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt(savedFieldName, int.parse(r.id.toString()));
      }
    });
    await EasyLoad.dismiss();
  }
}
