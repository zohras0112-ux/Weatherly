import 'package:flutter/material.dart';
import 'package:weather_app/data/model/forecast_model.dart';
import 'package:weather_icons_animated/weather_icons_animated.dart';
import 'package:weather_app/util/weather_icon_map.dart';

class ForecastWidget extends StatelessWidget {
  final List<Forecast> forecast;

  const ForecastWidget({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: forecast.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: WeatherIcon(
              icon: getWeatherIcon(forecast[index].iconCode),
              size: 50,
              format: WeatherIconFormat.lottie,
            ),
            title: Text(forecast[index].day),
            trailing: Text('${forecast[index].temp}°C'),
          ),
        );
      },
    );
  }
}
