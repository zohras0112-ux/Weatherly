import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/model/hourly_forecast_model.dart';
import 'dart:async';

class HourlyWeatherForecast {
  Future<List<HourlyForecast>> getHourlyForecast(String city) async {
    final apiKey = dotenv.env['WEATHER_API_KEY'];
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric';

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List list = data['list'];
        final now = DateTime.now();

        final filtered = list
            .where((item) => DateTime.parse(item['dt_txt']).isAfter(now))
            .take(5)
            .toList();

        return filtered.map((item) => HourlyForecast.fromJson(item)).toList();
      }
      if (response.statusCode == 404) {
        throw Exception("City not found.");
      }
      throw Exception(data['message'] ?? 'Failed to loaad weather :(');
    } on TimeoutException {
      throw Exception('Request timed out. Please try agian later');
    } on http.ClientException {
      throw Exception("No internet connection.");
    } catch (_) {
      rethrow;
    }
  }
}
