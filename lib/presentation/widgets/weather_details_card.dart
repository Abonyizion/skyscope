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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        children: [
          Icon(icon,
              size: 26.sp,
          color: AppColors.topBackground,),
          SizedBox(height: 6.h),
          Text(title,
              style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.grey)),
          SizedBox(
              height: 6.h),
          Text(
            value,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
