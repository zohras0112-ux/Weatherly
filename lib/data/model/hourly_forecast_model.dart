import 'package:intl/intl.dart';

class HourlyForecast {
  final String time;
  final String iconCode;
  final double temp;

  HourlyForecast({
    required this.time,
    required this.iconCode,
    required this.temp,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    final dateTime = DateTime.parse(json['dt_txt']);
    final formattedTime = DateFormat('ha').format(dateTime);
    return HourlyForecast(
      time: formattedTime,
      temp: json['main']['temp'].toDouble(),
      iconCode: json['weather'][0]['icon'],
    );
  }
}
