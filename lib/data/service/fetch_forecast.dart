import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/model/forecast_model.dart';

class WeatherForecasts {
  Future<List<Forecast>> getForecast(String city) async {
    final apiKey = dotenv.env['WEATHER_API_KEY'];
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List forecasts = data['list'];

      final dailyForecasts = forecasts
          .where((item) {
            return item['dt_txt'].toString().contains('12:00:00');
          })
          .take(5)
          .toList();

      return dailyForecasts.map((item) => Forecast.fromJson(item)).toList();
    } else {
      throw Exception('Failed ot load weather:(');
    }
  }
}
