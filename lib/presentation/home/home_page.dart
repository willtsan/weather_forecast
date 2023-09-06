import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_forecast/presentation/home/components/weather_tile_component.dart';
import 'package:weather_forecast/presentation/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: const Text("Weather Forecast"),
        actions: [
          Obx(() {
            if (controller.loading || controller.error) {
              return const SizedBox.shrink();
            } else {
              if (controller.cities.isEmpty) {
                return const SizedBox.shrink();
              } else {
                return TextButton(
                  onPressed: () {
                    controller.clear();
                  },
                  child: const Text(
                    'Clear',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            }
          })
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 10),
        child: Obx(
          () {
            if (controller.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(controller.errorMessage,
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: const Text(
                        "Try Again",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        controller.reset();
                      },
                    )
                  ],
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) {
                        controller.search(value);
                        searchController.text = '';
                      },
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              controller.search(searchController.text);
                              searchController.text = '';
                            },
                          )),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(() {
                      return ListView.separated(
                        itemBuilder: (context, index) => WeatherTileComponent(
                          cityData: controller.cities[index],
                        ),
                        itemCount: controller.cities.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        shrinkWrap: true,
                      );
                    }),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
