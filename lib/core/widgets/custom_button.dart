
import 'package:em_school/core/layout/screen_size.dart';
import 'package:em_school/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../layout/app_radius.dart';
import '../layout/app_sizes.dart';




class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    this.backgroundColor = ColorsApp.mainColor,
    this.borderSide = BorderSide.none,
    this.titleColor = Colors.white,
    required this.onPressed,
    this.elevation = 2.0,
    this.fontSize,this.height,this.radius
  }) : super(key: key);

  final Color backgroundColor;
  final BorderSide borderSide;
  final String title;
  final Color titleColor;
  final VoidCallback? onPressed;
  final double? fontSize,height;
  final BorderRadius? radius;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.wSize,
      height:height?? AppSize.s50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
            backgroundColor,
          ),
          elevation: MaterialStateProperty.all(elevation),
          shape: MaterialStateProperty.resolveWith((states) {
            if (!states.contains(MaterialState.pressed)) {
              return RoundedRectangleBorder(
                borderRadius:radius??AppRadius.r10,
                side: borderSide,
              );
            }
            return  RoundedRectangleBorder(
              borderRadius:radius?? AppRadius.r10,
            );
          }),
        ),
        child: Text(
          title,
          style: GoogleFonts.rubik(
            color: titleColor,
            fontWeight: FontWeight.bold,
            fontSize:fontSize?? 16.sp

          ),
        ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon({
    Key? key,
    required this.title,
    this.backgroundColor = ColorsApp.mainColor,
    this.borderSide = BorderSide.none,
    this.titleColor = Colors.white,
    required this.onPressed,
    this.elevation = 2.0,
    required this.icon,
  }) : super(key: key);

  final Color backgroundColor;
  final BorderSide borderSide;
  final String title;
  final Color titleColor;
  final VoidCallback? onPressed;
  final double elevation;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.wSize,
      height: AppSize.s46,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(
          title,
          style:
             GoogleFonts.rubik(
                color: titleColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp

            ),

          maxLines: 1,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          elevation: MaterialStateProperty.all(elevation),
          shape: MaterialStateProperty.resolveWith((states) {
            if (!states.contains(MaterialState.pressed)) {
              return RoundedRectangleBorder(
                borderRadius: AppRadius.r10,
                side: borderSide,
              );
            }
            return const RoundedRectangleBorder(
              borderRadius: AppRadius.r10,
            );
          }),
        ),
      ),
    );
  }
}
