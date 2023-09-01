import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_forecast/presentation/home/home.bindings.dart';
import 'package:weather_forecast/presentation/home/home.page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/home',
          page: () => const HomePage(),
          binding: HomeBindings(),
        )
      ],
      initialRoute: '/home',
    );
  }
}
