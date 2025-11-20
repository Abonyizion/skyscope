class Weather {
  final double temp;
  final String description;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String icon;
  final double tempMin;
  final double tempMax;
  final String main;
  final String cityName;

  Weather({
    required this.temp,
    required this.description,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
    required this.tempMin,
    required this.tempMax,
    required this.main,
    required this.cityName,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final mainJson = json['main'] ?? {};
    final wind = json['wind'] ?? {};
    final weatherList = json['weather'] as List? ?? [];

    return Weather(
      cityName: json['name'],
      temp: (mainJson['temp'] ?? 0).toDouble(),
      feelsLike: (mainJson['feels_like'] ?? 0).toDouble(),
      tempMin: (mainJson['temp_min'] ?? 0).toDouble(),
      tempMax: (mainJson['temp_max'] ?? 0).toDouble(),
      humidity: (mainJson['humidity'] ?? 0).toInt(),
      windSpeed: (wind['speed'] ?? 0).toDouble(),
      icon: weatherList.isNotEmpty ? weatherList[0]['icon'] : '',
      description: weatherList.isNotEmpty ? weatherList[0]['description'] : '',
      main: weatherList.isNotEmpty ? weatherList[0]['main'] : "Unknown",
    );
  }

  Map<String, dynamic> toJson() => {
    'temp': temp,
    'feels_like': feelsLike,
    'temp_min': tempMin,
    'temp_max': tempMax,
    'humidity': humidity,
    'wind_speed': windSpeed,
    'icon': icon,
    'description': description,
    'main': main,
    'cityName': cityName
  };
}
