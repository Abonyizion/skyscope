import 'package:dio/dio.dart';
import '../models/weather.dart';
import '../models/hourly_forecast.dart';

class WeatherApi {
  final String apiKey;
  final Dio dio;

  WeatherApi({required this.apiKey, Dio? dioClient})
      : dio = dioClient ??
      Dio(BaseOptions(
        baseUrl: "https://api.openweathermap.org/data/2.5/",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ));

  /// Get current weather
  Future<Weather> fetchCurrentWeather(double lat, double lon) async {
    try {
      final response = await dio.get(
        'weather',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'units': 'metric',
          'appid': apiKey,
        },
      );

      return Weather.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Request timed out. Pull to retry.");
      }
      throw Exception('Failed to fetch current weather: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch current weather: $e');
    }
  }

  /// Get hourly forecast
  Future<List<HourlyForecast>> fetchHourlyForecast(double lat, double lon) async {
    try {
      final response = await dio.get(
        'forecast',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'units': 'metric',
          'appid': apiKey,
        },
      );

      final list = response.data['list'] as List;

      return list
          .map((item) => HourlyForecast(
        dt: item['dt'],
        temp: (item['main']['temp'] as num).toDouble(),
        icon: item['weather'][0]['icon'],
        main: item['weather'][0]['main'] ?? "Unknown",
      ))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Request timed out. Pull to retry.");
      }
      throw Exception('Failed to fetch hourly forecast: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch hourly forecast: $e');
    }
  }
}
