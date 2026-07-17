class Weather {
  final String city;
  final String iconCode;
  final double temp;
  final String description;

  Weather({
    required this.city,
    required this.iconCode,
    required this.temp,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      iconCode: json['weather'][0]['icon'],
      city: json['name'],
      temp: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}
