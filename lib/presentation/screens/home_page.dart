import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_scope/core/constants/api_constants.dart';
import 'package:sky_scope/core/constants/general_constants.dart';
import 'package:sky_scope/presentation/widgets/custom_shimmer.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routing/app_router.dart';
import '../../core/utils/date_formatter.dart';
import '../../core/utils/weather_lottie_mapper.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';
import '../widgets/main_weather_card.dart';
import '../widgets/weather_details_card.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {


  @override
  void initState() {
    super.initState();
    // Fetch location ONCE when home page loads
    context.read<WeatherBloc>().add(const FetchWeatherByLocation());
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: AppColors.homeBg,
        body: SafeArea(
          child: Padding(
            padding: GeneralConstants.scaffoldPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.person, size: 28.sp),

                    // City name from BLoC state
                    BlocBuilder<WeatherBloc, WeatherState>(
                      buildWhen: (previous, current) =>
                      current is WeatherLoaded || current is WeatherError || current is WeatherLoading,
                      builder: (context, state) {
                        Widget cityWidget;

                        if (state is WeatherLoading) {
                          // Show a small circular spinner while loading
                          cityWidget = SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        } else if (state is WeatherLoaded) {
                          cityWidget = Text(
                            state.currentWeather.cityName,
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                          );
                        } else if (state is WeatherError) {
                          cityWidget = Text(
                            "Location Error",
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                          );
                        } else {
                          cityWidget = Text(
                            "Loading...",
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                          );
                        }

                        return Row(
                          children: [
                            Icon(Icons.location_on, size: 20.sp),
                            SizedBox(width: 14.w),
                            cityWidget,
                          ],
                        );
                      },
                    ),

                    InkWell(
                      onTap: () => context.push(AppRouter.searchCity),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.search_rounded,
                              size: 28.sp),
                        ),
                    ),
                  ],
                ),

                SizedBox(height: 15.h),

                Expanded(
                  child: BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      return RefreshIndicator(
                          onRefresh: () async {
                            context.read<WeatherBloc>().add(const FetchWeatherByLocation());
                          },
                          child: _buildStateContent(state),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
     // ),
    );
  }

  Widget _buildStateContent(WeatherState state) {
    if (state is WeatherLoading) {
      return const SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: WeatherShimmer(),
      );
    }

    if (state is WeatherError) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
              state.message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp,
                  color: AppColors.red),
            ),
        ),
      );
    }

    if (state is WeatherLoaded) {
      final weather = state.currentWeather;
      final hourly = state.hourlyForecast;

      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            WeatherCard(
              iconWidget: Lottie.asset(
                WeatherLottieMapper.getAnimation(weather.main),
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),
              temperature: "${weather.temp.round()}°C",
              description: weather.description,
              highLow:
              "H: ${weather.tempMax.round()}° • L: ${weather.tempMin.round()}°",
            ),

            SizedBox(height: 35.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "3-Hour Forecast",
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormatter.formatDateTime(DateTime.now(),),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Hourly Forecast List
            SizedBox(
              height: 120.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: hourly.length,
                separatorBuilder: (_, __) => SizedBox(width: 14.w),
                itemBuilder: (context, index) {
                  final item = hourly[index];
                  return Container(
                    width: 80.w,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                     // color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.topBackground,
                          AppColors.bottomBackground,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _formatHour(item.dt),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                              fontSize: 12.sp),
                        ),
                        SizedBox(
                            height: 6.h),
                        Lottie.asset(
                          WeatherLottieMapper.getAnimation(item.main),
                          height: 40.h,
                          width: 40.h,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 6.h),
                        Text("${item.temp.round()}°",
                            style: TextStyle(
                                fontSize: 14.sp,
                              color: AppColors.white,)),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 30.h),

            Text(
              "Weather Details",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),

            // Weather Details Cards
            LayoutBuilder(
              builder: (context, constraints) {
                double cardWidth = (constraints.maxWidth - 20.w) / 3;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: WeatherDetailsCardCard(
                        icon: Icons.water_drop,
                        title: 'Humidity',
                        value: '${weather.humidity}%',
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: WeatherDetailsCardCard(
                        icon: Icons.wind_power,
                        title: 'Wind',
                        value: '${weather.windSpeed} km/h',
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: WeatherDetailsCardCard(
                        icon: Icons.thermostat,
                        title: 'Feels Like',
                        value: '${weather.feelsLike.round()}°',
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  /// Convert UNIX timestamp → "1 PM"
  String _formatHour(int dt) {
    final date =
    DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true).toLocal();
    return "${date.hour % 12 == 0 ? 12 : date.hour % 12} ${date.hour >= 12 ? 'PM' : 'AM'}";
  }
}
