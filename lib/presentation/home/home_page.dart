import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_forecast/presentation/home/components/weather_tile_component.dart';
import 'package:weather_forecast/presentation/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  final TextEditingController searchController = TextEditingController();

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
                  key: const Key("clear_button"),
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
                child: CircularProgressIndicator(
                  key: Key('loading'),
                ),
              );
            } else if (controller.error) {
              return Center(
                child: Column(
                  key: const Key('error_message'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(controller.errorMessage,
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      key: const Key('try_again_button'),
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
                      key: const Key('search_field'),
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
                            key: const Key('search_button'),
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
                      if (controller.cities.isEmpty) {
                        return const Center(
                          child: Text(
                              key: Key('empty_cities_message'),
                              "Search a city to see\nthe current weather and forecast",
                              textAlign: TextAlign.center),
                        );
                      } else {
                        return ListView.separated(
                          key: const Key('cities_list'),
                          itemBuilder: (context, index) => WeatherTileComponent(
                            key: Key('city_$index'),
                            cityData: controller.cities[index],
                          ),
                          itemCount: controller.cities.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          shrinkWrap: true,
                        );
                      }
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
