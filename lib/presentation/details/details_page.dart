import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_forecast/presentation/details/details_controller.dart';

class DetailsPage extends GetView<DetailsController> {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.offNamed('/home');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            children: [Text(controller.teste.value)],
          );
        }),
      ),
    );
  }
}
