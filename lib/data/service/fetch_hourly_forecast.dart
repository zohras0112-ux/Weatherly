import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/model/hourly_forecast_model.dart';

class HourlyWeatherForecast {
  Future<List<HourlyForecast>> getHourlyForecast(String city) async {
    final apiKey = dotenv.env['WEATHER_API_KEY'];
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List list = data['list'];
      final now = DateTime.now();

      final filtered = list
          .where((item) => DateTime.parse(item['dt_txt']).isAfter(now))
          .take(5)
          .toList();

      return filtered.map((item) => HourlyForecast.fromJson(item)).toList();
    } else {
      throw Exception('Failed ot load weather:(');
    }
  }
}
