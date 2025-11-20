// lib/presentation/bloc/weather_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/weather_repository.dart';
import '../../data/services/location_service.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;
  final LocationService locationService;

  WeatherBloc({
    required this.repository,
    required this.locationService,
  }) : super(WeatherInitial()) {
    on<FetchWeatherByLocation>(_onFetchByLocation);
    on<FetchWeather>(_onFetchWeather);
  }

  // Handler for explicit lat/lon fetch
  Future<void> _onFetchWeather(
      FetchWeather event,
      Emitter<WeatherState> emit,
      ) async {
    emit(WeatherLoading());
    try {
      final current = await repository.getCurrentWeather(
        event.latitude,
        event.longitude,
      );

      final hourly = await repository.getHourlyForecast(
        event.latitude,
        event.longitude,
      );

      emit(WeatherLoaded(currentWeather: current, hourlyForecast: hourly));
    } catch (e) {
      final msg = _cleanErrorMessage(e);
      emit(WeatherError(msg)); // second param = cityName (empty)
    }
  }

  // Handler that gets device location then fetches weather
  Future<void> _onFetchByLocation(
      FetchWeatherByLocation event,
      Emitter<WeatherState> emit,
      ) async {
    emit(WeatherLoading());
    try {
      final position = await locationService.getCurrentLocation();

      final current = await repository.getCurrentWeather(
        position.latitude,
        position.longitude,
      );

      final hourly = await repository.getHourlyForecast(
        position.latitude,
        position.longitude,
      );

      emit(WeatherLoaded(currentWeather: current, hourlyForecast: hourly));
    } catch (e) {
      final msg = _cleanErrorMessage(e);
      emit(WeatherError(msg)); // second param = cityName (empty)
    }
  }

  String _cleanErrorMessage(Object e) {
    final s = e?.toString() ?? 'Unknown error';
    // remove common "Exception: " prefix if present
    return s.replaceFirst(RegExp(r'^Exception:\s*'), '');
  }
}
