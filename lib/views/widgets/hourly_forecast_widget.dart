import 'package:flutter/material.dart';
import 'package:weather_icons_animated/weather_icons_animated.dart';
import 'package:weather_app/data/model/forecast_model.dart';
import 'package:weather_app/data/model/hourly_forecast_model.dart';
import 'package:weather_app/util/weather_icon_map.dart';

class HourlyForecastListWidget extends StatelessWidget {
  final List<HourlyForecast> hourlyforecast;
  final List<Forecast> forecast;

  const HourlyForecastListWidget({
    super.key,
    required this.hourlyforecast,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Card(
        child: Row(
          children: [
            ...hourlyforecast.map((item) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(item.time),
                    WeatherIcon(
                      icon: getWeatherIcon(item.iconCode),
                      size: 60,
                      format: WeatherIconFormat.lottie,
                    ),
                    Text('${item.temp}°C'),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
