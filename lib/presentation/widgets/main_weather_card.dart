import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/date_formatter.dart';

class WeatherCard extends StatelessWidget {
  final Widget iconWidget;
  final String temperature;
  final String description;
  final String highLow;

  const WeatherCard({
    super.key,
    required this.iconWidget,
    required this.temperature,
    required this.description,
    required this.highLow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
        padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [

          iconWidget,
          SizedBox(
              height: 8.h),
          Text(
            temperature,
            style: TextStyle(
              fontSize: 60.sp,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            description,
            style: TextStyle(
              fontSize: 22.sp,
              color: AppColors.lightGrey,
            ),
          ),

          SizedBox(height: 3.h),

          Text(
            highLow,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.lightGrey,
            ),
          ),
          SizedBox(height: 3.h),
        Text(
            DateFormatter.formatDateTime(DateTime.now(),),
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.lightGrey,
          ),
          ),
        ],
      ),
    );
  }
}
