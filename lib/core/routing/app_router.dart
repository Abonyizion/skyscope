import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/bloc/search/search_city_bloc.dart';
import '../../presentation/bloc/weather_bloc.dart';
import '../../presentation/screens/home_page.dart';
import '../../presentation/screens/search_screen.dart';
import '../../presentation/screens/splash_screen.dart';
import '../constants/api_constants.dart';
import 'package:dio/dio.dart';
import '../../../data/repositories/city_search_repository.dart';

class AppRouter {
  /// ********* ROUTE PATHS *********
  static const String splash = '/splash';
  static const String home = '/home';
  static const String searchCity = '/searchCity';



  /// ********* GOROUTER SETUP *********
  static final router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (_, __) => SplashPage(),
      ),
      GoRoute(
        path: home,
        builder: (_, __) => const WeatherHomePage(),
      ),
      GoRoute(
        path: searchCity,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            // Pass existing WeatherBloc down
            BlocProvider.value(
              value: BlocProvider.of<WeatherBloc>(context),
            ),
            // Provide new CitySearchBloc
            BlocProvider(
              create: (_) => CitySearchBloc(
                repository: CitySearchRepository(Dio(), ApiConstants.openWeatherMapKey),
              ),
            ),
          ],
          child: const SearchCityScreen(),
        ),
      ),

    ],
  );
}
