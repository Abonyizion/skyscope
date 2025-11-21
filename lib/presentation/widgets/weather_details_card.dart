import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';

class WeatherDetailsCardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const WeatherDetailsCardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
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
          Icon(icon,
              size: 26.sp,
          color: AppColors.white,),
          SizedBox(height: 6.h),
          Text(title,
              style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.white,)),
          SizedBox(
              height: 6.h),
          Text(
            value,
            style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.white,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
