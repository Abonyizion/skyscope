import 'package:equatable/equatable.dart';
import '../../data/models/hourly_forecast.dart';
import '../../data/models/weather.dart';


abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather currentWeather;
  final List<HourlyForecast> hourlyForecast;

  const WeatherLoaded({required this.currentWeather, required this.hourlyForecast});

  @override
  List<Object?> get props => [currentWeather, hourlyForecast];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}
