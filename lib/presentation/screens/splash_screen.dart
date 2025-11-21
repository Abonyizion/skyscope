import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_scope/presentation/widgets/custom_button.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routing/app_router.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.topBackground,
              AppColors.bottomBackground,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 80.h),

              Expanded(
                child: Lottie.asset(
                  "assets/lottie/clouds.json",
                  height: 210,
                  width: 210,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                  height: 40.h),
              Text(
                "WEATHER",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 50.sp,
                  color: AppColors.white,
                ),
              ),
              Text(
                "ForeCasts",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 48.sp,
                  color: AppColors.forecastTx,
                ),
              ),

              SizedBox(
                  height: 80.h),

              Padding(
                padding: EdgeInsets.only(
                  left: 50.w,
                  right: 50.w,
                  bottom: 100.h,
                ),
                child: CustomButton(
                  text: "Get Started",
                  onTap: () => context.go(AppRouter.home),
                  textColor: AppColors.buttonTx,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
