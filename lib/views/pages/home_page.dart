import 'package:flutter/material.dart';
import 'package:weather_app/data/model/forecast_model.dart';
import 'package:weather_app/data/model/hourly_forecast_model.dart';
import 'package:weather_app/data/model/weather_model.dart';
import 'package:weather_app/data/service/fetch_forecast.dart';
import 'package:weather_app/data/service/fetch_hourly_forecast.dart';
import 'package:weather_app/data/service/fetch_weather.dart';
import 'package:weather_app/views/widgets/forecast_widget.dart';
import 'package:weather_app/views/widgets/hourly_forecast_widget.dart';
import 'package:weather_app/views/widgets/weather_widget.dart';

class HomePage extends StatefulWidget {
  final String city;

  const HomePage({super.key, required this.city});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService weatherservice = WeatherService();
  final WeatherForecasts weatherForecasts = WeatherForecasts();
  final HourlyWeatherForecast hourlyweatherforecast = HourlyWeatherForecast();

  Weather? weather;
  List<Forecast>? forecast;
  List<HourlyForecast>? hourlyforecast;

  @override
  void initState() {
    super.initState();
    loadWeather(widget.city);
    loadForecast(widget.city);
    loadHourlyForecast(widget.city);
  }

  Future<void> loadWeather(String city) async {
    try {
      final result = await weatherservice.getWeather(city);

      if (!mounted) return;

      setState(() {
        weather = result;
      });
    } catch (e) {
      SnackBar(content: Text("Unable to fetch weather :()"));
    }
  }

  Future<void> loadForecast(String city) async {
    try {
      final result = await weatherForecasts.getForecast(city);

      if (!mounted) return;

      setState(() {
        forecast = result;
      });
    } catch (e) {
      SnackBar(content: Text("Unable to fetch weather :()"));
    }
  }

  Future<void> loadHourlyForecast(String city) async {
    try {
      final result = await hourlyweatherforecast.getHourlyForecast(city);

      if (!mounted) return;

      setState(() {
        hourlyforecast = result;
      });
    } catch (e) {
      SnackBar(content: Text("Unable to fetch weather :()"));
    }
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.city != widget.city) {
      setState(() {
        weather = null;
        forecast = null;
        hourlyforecast = null;
      });

      loadWeather(widget.city);
      loadForecast(widget.city);
      loadHourlyForecast(widget.city);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (weather == null || forecast == null || hourlyforecast == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),

        child: Column(
          children: [
            WeatherWidget(weather: weather!),
            SizedBox(height: 50),
            HourlyForecastListWidget(
              hourlyforecast: hourlyforecast!,
              forecast: forecast!,
            ),
            SizedBox(height: 50),
            ForecastWidget(forecast: forecast!),
          ],
        ),
      ),
    );
  }
}
