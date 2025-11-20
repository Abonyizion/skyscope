import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';

class WeatherShimmer extends StatelessWidget {
  const WeatherShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.lightGrey.withOpacity(0.3),
      highlightColor: Colors.white.withOpacity(0.7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 230.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.r),
            ),
          ),
          SizedBox(height: 24.h),

          Container(
            width: 150.w,
            height: 25.h,
            color: Colors.white,
          ),
          SizedBox(
              height: 14.h),

          SizedBox(
            height: 140.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => SizedBox(
                  width: 14.w),
              itemBuilder: (context, index) => Container(
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
          ),
          SizedBox(
              height: 15.h),
          Container(
            width: 180.w,
            height: 25.h,
            color: Colors.white,
          ),
          SizedBox(
              height: 14.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3,
                  (index) => Container(
                width: (MediaQuery.of(context).size.width - 42.w) / 3,
                height: 120.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
