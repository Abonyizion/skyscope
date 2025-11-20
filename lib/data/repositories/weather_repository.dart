import '../models/hourly_forecast.dart';
import '../models/weather.dart';
import '../services/weather_api.dart';

class WeatherRepository {
  final WeatherApi api;

  WeatherRepository({required this.api});

  Future<Weather> getCurrentWeather(double lat, double lon) async {
    return await api.fetchCurrentWeather(lat, lon);
  }

  Future<List<HourlyForecast>> getHourlyForecast(double lat, double lon) async {
    return await api.fetchHourlyForecast(lat, lon);
  }
}
