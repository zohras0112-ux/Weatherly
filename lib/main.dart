import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/data/notifiers.dart';
import 'package:weather_app/data/service/prefference_service.dart';
import 'package:weather_app/views/pages/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PrefferenceService();
  await dotenv.load(fileName: ".env");
  isDarkNotifier.value = await prefs.getSavedTheme();
  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: value ? ThemeMode.dark : ThemeMode.light,
          home: const WelcomePage(),
        );
      },
    );
  }
}
