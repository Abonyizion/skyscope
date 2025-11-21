import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sky_scope/core/constants/general_constants.dart';
import '../../core/constants/app_colors.dart';
import '../bloc/search/search_city_bloc.dart';
import '../bloc/search/search_city_event.dart';
import '../bloc/search/search_city_state.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';


class SearchCityScreen extends StatelessWidget {
  const SearchCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBg,
      body: SafeArea(
        child: Padding(
          padding: GeneralConstants.scaffoldPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.h,
              ),
              InkWell(
                onTap: () =>  GoRouter.of(context).pop(),
             child: Icon(Icons.arrow_back,
                    size: 28.sp),
              ),
              SizedBox(
                height: 17.h,
              ),
              _roundedInputField(
                hint:  "Search city...",
                keyboardType: TextInputType.text,
                onChanged:  (value) {
                  context.read<CitySearchBloc>().add(SearchCity(value));
                },
              ),
              Expanded(
                child: BlocBuilder<CitySearchBloc, CitySearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (state is SearchLoaded) {
                      if (state.results.isEmpty) {
                        return Center(
                            child: Text("No results found"));
                      }
                      return ListView.builder(
                        itemCount: state.results.length,
                        itemBuilder: (context, index) {
                          final item = state.results[index];

                          return ListTile(
                            title: Text(item["name"]),
                            subtitle: Text("${item["state"] ?? ""}, "
                                "${item["country"]}"
                            ),
                            onTap: () {
                              final lat = (item['lat'] as num).toDouble();
                              final lon = (item['lon'] as num).toDouble();

                              context.read<WeatherBloc>().add(
                                FetchWeather(latitude: lat, longitude: lon),
                              );
                              // Delay pop to next frame so Bloc updates first
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                context.pop();
                              });
                            },
                          );
                        },
                      );
                    }
                    return SizedBox();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _roundedInputField({
    required ValueChanged onChanged,
    String? hint,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.bottomBackground
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            onChanged: onChanged,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              hintText: hint,
              prefixIcon: Icon(Icons.search),
              hintStyle: TextStyle(
                  fontSize: 12,
                  color: AppColors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
