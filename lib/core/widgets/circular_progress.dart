import 'package:em_school/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../layout/app_sizes.dart';





class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({
    super.key,

    this.strokeWidth = AppSize.s3,
    this.color = ColorsApp.mainColor,
    this.fullScreen = false,
  });


  final double strokeWidth;
  final Color color;
  final bool fullScreen;

  @override
  Widget build(BuildContext context) {
    if (fullScreen) {
      return Scaffold(
        body: Center(
          child: SizedBox(
            width: 28.w,
            height: 28.h,


            child: Center(
              child: CircularProgressIndicator.adaptive(
                strokeWidth: strokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
        ),
      );
    }
    return Center(
      child: SizedBox(
        width: 28.w,
        height: 28.h,
        child: Center(
          child: CircularProgressIndicator.adaptive(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ),
    );
  }
}
