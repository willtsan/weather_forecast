import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/presentation/details/details_controller.dart';

class DetailsPage extends GetView<DetailsController> {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offNamed('/home');
          },
        ),
        title: Obx(() {
          if (controller.cityData.value != null) {
            return Text(controller.cityData.value!.cityName);
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            if (controller.cityData.value != null) {
              return Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                        convertToWeekDay(
                          DateTime.now(),
                        ),
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 20,
                    ),
                    CachedNetworkImage(
                      height: 200,
                      fit: BoxFit.fitHeight,
                      errorWidget: (context, url, error) => const Icon(
                        Icons.warning_sharp,
                        size: 60,
                        color: Colors.orange,
                      ),
                      placeholder: (context, url) => const FittedBox(
                        fit: BoxFit.contain,
                        child: CircularProgressIndicator(),
                      ),
                      imageUrl:
                          'http://openweathermap.org/img/wn/${controller.cityData.value!.weather.current!.weather!.first.icon}@2x.png',
                    ),
                    Text(
                      "${controller.cityData.value!.weather.current!.temp!.round()}°C",
                      style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        controller.cityData.value!.weather.current!.weather!
                            .first.description,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      height: 160,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => index == 0
                              ? Container()
                              : SizedBox(
                                  width: 130,
                                  child: Card(
                                    color: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Column(
                                        children: [
                                          Text(
                                            convertToWeekDay(
                                              DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                controller
                                                        .cityData
                                                        .value!
                                                        .weather
                                                        .daily![index]
                                                        .dt! *
                                                    1000,
                                              ),
                                            ),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          CachedNetworkImage(
                                            height: 50,
                                            fit: BoxFit.fitHeight,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.warning_sharp,
                                              size: 60,
                                              color: Colors.orange,
                                            ),
                                            placeholder: (context, url) =>
                                                const FittedBox(
                                              fit: BoxFit.contain,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            imageUrl:
                                                'http://openweathermap.org/img/wn/${controller.cityData.value!.weather.daily![index].weather![0].icon}@2x.png',
                                          ),
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              controller
                                                  .cityData
                                                  .value!
                                                  .weather
                                                  .daily![index]
                                                  .weather![0]
                                                  .description,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "${controller.cityData.value!.weather.daily![index].temp!.max!.round()}°C",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                              "${controller.cityData.value!.weather.daily![index].temp!.min!.round()}°C",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 5),
                          itemCount:
                              controller.cityData.value!.weather.daily!.length -
                                  2),
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  String convertToWeekDay(DateTime date) {
    return DateFormat('EEEE').format(date.toLocal());
  }
}
