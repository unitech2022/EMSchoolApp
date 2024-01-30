import 'package:em_school/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/styles.dart';

class TextFormFieldWidget extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText, isEnabled;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String?) validator;

  const TextFormFieldWidget({super.key,
    this.textInputType,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText, this.isEnabled,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled ?? true,
      controller: controller,
      keyboardType: textInputType ?? TextInputType.text,
      textAlign: TextAlign.start,
      style: inputTextStyle ?? TextStyles.textStyleFontBold20White,
      obscureText: isObscureText ?? true,
      decoration: InputDecoration(

        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFB2B5B9),
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 38.h),
        isDense: false,
        filled: true,
        fillColor: backgroundColor ?? ColorsApp.backgroundColor,
suffixIcon: suffixIcon??const SizedBox(),
        hintStyle: hintStyle ??TextStyles.textStyleFontExtraBold12White,
        counterText: "",
        labelText: hintText,
        labelStyle:TextStyles.textStyleFontExtraBold12White,

      ),

    );
  }
}



class TextFormFieldAreaWidget extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText, isEnabled;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String?) validator;

  const TextFormFieldAreaWidget({super.key,
    this.textInputType,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText, this.isEnabled,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled ?? true,
      controller: controller,
      maxLines: null,
      
      keyboardType:  TextInputType.multiline,
      textAlign: TextAlign.start,
      style: inputTextStyle ?? TextStyles.textStyleFontBold20White,
      obscureText: isObscureText ?? true,
      decoration: InputDecoration(
    
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFB2B5B9),
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 38.h),
        isDense: false,
        filled: true,
        fillColor: backgroundColor ?? ColorsApp.backgroundColor,
    suffixIcon: suffixIcon??const SizedBox(),
        hintStyle: hintStyle ??TextStyles.textStyleFontExtraBold12White,
        counterText: "",
        labelText: hintText,
        labelStyle:TextStyles.textStyleFontExtraBold12White,
    
      ),
    
    );
  }
}
