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
  final ValueChanged<String> onCityResolved;

  const HomePage({super.key, required this.city, required this.onCityResolved});

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

  bool isLoading = true;
  String? errorMessage;

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
      widget.onCityResolved(result.city);

      if (!mounted) return;

      setState(() {
        weather = result;

        if (weather != null && forecast != null && hourlyforecast != null) {
          isLoading = false;
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
        isLoading = false;
      });
    }
  }

  Future<void> loadForecast(String city) async {
    try {
      final result = await weatherForecasts.getForecast(city);

      if (!mounted) return;

      setState(() {
        forecast = result;
        if (weather != null && forecast != null && hourlyforecast != null) {
          isLoading = false;
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
        isLoading = false;
      });
    }
  }

  Future<void> loadHourlyForecast(String city) async {
    try {
      final result = await hourlyweatherforecast.getHourlyForecast(city);

      if (!mounted) return;

      setState(() {
        hourlyforecast = result;
        if (weather != null && forecast != null && hourlyforecast != null) {
          isLoading = false;
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
        isLoading = false;
      });
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

        isLoading = true;
        errorMessage = null;
      });

      loadWeather(widget.city);
      loadForecast(widget.city);
      loadHourlyForecast(widget.city);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
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
