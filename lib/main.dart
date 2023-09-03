import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/presentation/home/home_bindings.dart';
import 'package:weather_forecast/presentation/home/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder<http.Client>.put(() => http.Client()),
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
