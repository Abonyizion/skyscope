class HourlyForecast {
  final int dt;
  final double temp;
  final String icon;

  HourlyForecast({
    required this.dt,
    required this.temp,
    required this.icon,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    final main = json['main'] ?? {};
    final weatherList = json['weather'] as List? ?? [];

    return HourlyForecast(
      dt: json['dt'] ?? 0,
      temp: (main['temp'] ?? 0).toDouble(),
      icon: weatherList.isNotEmpty ? weatherList[0]['icon'] : '',
    );
  }

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'temp': temp,
    'icon': icon,
  };
}
