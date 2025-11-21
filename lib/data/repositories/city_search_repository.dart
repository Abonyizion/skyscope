import 'package:dio/dio.dart';

class CitySearchRepository {
  final Dio dio;
  final String apiKey;

  CitySearchRepository(this.dio, this.apiKey);

  Future<List<Map<String, dynamic>>> searchCities(String query) async {
    final url =
        "http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=10&appid=$apiKey";

    final response = await dio.get(url);

    final data = response.data as List;

    return data.map((item) {
      return {
        "name": item["name"],
        "lat": item["lat"],
        "lon": item["lon"],
        "country": item["country"],
        "state": item["state"],
      };
    }).toList();
  }
}
