import 'package:flutter/material.dart';
import 'package:weather_app/data/notifiers.dart';
import 'package:weather_app/data/service/prefference_service.dart';
import 'package:weather_app/views/pages/home_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  String city = 'Mumbai';
  final PrefferenceService prefs = PrefferenceService();

  @override
  void initState() {
    super.initState();
    loadSavedCity();
  }

  Future<void> loadSavedCity() async {
    final savedCity = await prefs.getSavedCity();

    if (savedCity != null) {
      setState(() {
        city = savedCity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_on, size: 18),
            const SizedBox(width: 5),
            Text(city),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final controller = TextEditingController();
              await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Search City'),
                    content: TextField(
                      controller: controller,
                      autofocus: true,
                      onSubmitted: (value) async {
                        if (value.trim().isNotEmpty) {
                          await prefs.saveCity(value.trim());
                          setState(() {
                            city = value.trim();
                          });
                        }
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () async {
              isDarkNotifier.value = !isDarkNotifier.value;

              final prefs = PrefferenceService();
              await prefs.saveTheme(isDarkNotifier.value);
            },
            icon: ValueListenableBuilder(
              valueListenable: isDarkNotifier,
              builder: (BuildContext context, dynamic value, Widget? child) {
                return Icon(value ? Icons.light_mode : Icons.dark_mode);
              },
            ),
          ),
        ],
      ),
      body: HomePage(
        city: city,
        onCityResolved: (resolvedCity) {
          setState(() {
            city = resolvedCity;
          });
        },
      ),
    );
  }
}
