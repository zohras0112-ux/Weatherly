import 'package:intl/intl.dart';

class Forecast {
  final String day;
  final double temp;
  final String iconCode;

  Forecast({required this.day, required this.temp, required this.iconCode});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    final dtTxt = json['dt_txt'] ?? '';

    final dateTime = dtTxt.isNotEmpty ? DateTime.parse(dtTxt) : DateTime.now();

    final formattedDay = DateFormat('E').format(dateTime);

    final tempValue = json['main']?['temp'] ?? 0.0;

    final icon =
        (json['weather'] != null &&
            json['weather'].isNotEmpty &&
            json['weather'][0]['icon'] != null)
        ? json['weather'][0]['icon']
        : '01d'; // default icon

    return Forecast(
      iconCode: icon,
      day: formattedDay,
      temp: (tempValue as num).toDouble(),
    );
  }
}
