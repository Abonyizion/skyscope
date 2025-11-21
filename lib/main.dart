import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';

import 'package:sky_scope/presentation/bloc/search/search_city_bloc.dart';
import 'package:sky_scope/data/repositories/city_search_repository.dart';
import 'package:sky_scope/presentation/bloc/weather_bloc.dart';
import 'package:sky_scope/data/repositories/weather_repository.dart';

import 'core/constants/api_constants.dart';
import 'core/routing/app_router.dart';
import 'data/services/location_service.dart';
import 'data/services/weather_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final dio = Dio();
  final weatherApi = WeatherApi(apiKey: ApiConstants.openWeatherMapKey);
  final weatherRepository = WeatherRepository(api: weatherApi);
  final locationService = LocationService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => WeatherBloc(
            repository: weatherRepository,
            locationService: locationService,
          ),
        ),
        BlocProvider(
          create: (_) => CitySearchBloc(
            repository: CitySearchRepository(dio, ApiConstants.openWeatherMapKey),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
