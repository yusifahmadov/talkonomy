import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';
import 'core/bloc_observer.dart';
import 'core/easy_loading/easy_loading.dart';
import 'injection.dart' as di;

void main() async {
  await di.init();
  await EasyLoad.init();
  await dotenv.load(fileName: ".env");
  BlocOverrides.runZoned(() {
    runApp(const MaterialApp(
      home: App(),
    ));
  }, blocObserver: AppBlocObserver());
}
