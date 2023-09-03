import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_forecast/presentation/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Weather Forecast"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          const TextField(
            decoration: InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black))),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemBuilder: (context, index) => ListTile(
                onTap: () {},
                title: const Text("Cidade"),
              ),
              itemCount: 20,
              //shrinkWrap: true,
            ),
          ),
          TextButton(
              onPressed: () => controller.fetchData(),
              child: const Text("teste api"))
        ]),
      ),
    );
  }
}
