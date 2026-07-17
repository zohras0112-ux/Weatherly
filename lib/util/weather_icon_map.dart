import 'package:weather_icons_animated/weather_icons_animated.dart';

WeatherIconData getWeatherIcon(String code) {
  switch (code) {
    case '01d':
      return WeatherIcons.named('clear-day');

    case '01n':
      return WeatherIcons.named('clear-night');

    case '02d':
      return WeatherIcons.named('partly-cloudy-day');

    case '02n':
      return WeatherIcons.named('partly-cloudy-night');

    case '03d':
    case '03n':
    case '04d':
    case '04n':
      return WeatherIcons.named('overcast');

    case '09d':
    case '09n':
    case '10d':
    case '10n':
      return WeatherIcons.named('rain');

    case '11d':
    case '11n':
      return WeatherIcons.named('thunderstorms');

    case '13d':
    case '13n':
      return WeatherIcons.named('snow');

    case '50d':
    case '50n':
      return WeatherIcons.named('fog');

    default:
      return WeatherIcons.named('clear-day');
  }
}
