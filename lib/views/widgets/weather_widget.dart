import 'package:flutter/material.dart';
import 'package:weather_icons_animated/weather_icons_animated.dart';
import 'package:weather_app/data/model/weather_model.dart';
import 'package:weather_app/util/weather_icon_map.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  const WeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          WeatherIcon(
            icon: getWeatherIcon(weather.iconCode),
            size: 120,
            format: WeatherIconFormat.lottie,
          ),

          SizedBox(height: 10),
          Text(
            '${weather.temp}°C',
            style: TextStyle(fontSize: 22, letterSpacing: 1.2),
          ),
          SizedBox(height: 15),
          Text(
            weather.description,
            style: TextStyle(fontSize: 22, letterSpacing: 1.2),
          ),
        ],
      ),
    );
  }
}
