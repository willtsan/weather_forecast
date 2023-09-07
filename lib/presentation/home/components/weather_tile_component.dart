import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_forecast/data/models/city_model.dart';
import 'package:weather_forecast/env/env.dart';

class WeatherTileComponent extends StatelessWidget {
  final CityModel cityData;

  const WeatherTileComponent({Key? key, required this.cityData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.toNamed('/details', arguments: cityData);
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                cityData.cityName,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${cityData.weather.current!.temp!.round()}°C",
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          cityData.weather.current!.weather!.first.description,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: CachedNetworkImage(
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
                          '${Env.baseWeatherIconsUrl}${cityData.weather.current!.weather!.first.icon}@2x.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
