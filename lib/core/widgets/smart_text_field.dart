import 'package:em_school/core/extensions/theme_extension.dart';
import 'package:em_school/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../layout/app_sizes.dart';




@immutable
class RegularTextField extends StatelessWidget {
  const RegularTextField({
    super.key,
    this.label,
    this.onPressed,
    this.readOnly = false,
    this.hint,
    this.controller,
    this.validator,
  });

  final String? label;
  final String? hint;
  final GestureTapCallback? onPressed;
  final bool readOnly;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
      fontSize: 16,
      color: ColorsApp.mainColor,
      fontWeight: FontWeight.bold,
    );
    return TextFormField(
      controller: controller,
      onTap: onPressed,
      readOnly: readOnly,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        label: hint != null
            ? null
            : Text(
                label!,
                style: textStyle,
              ),
        floatingLabelStyle: textStyle,
      ),
    );
  }
}

class SmartTextField extends StatelessWidget {
  const SmartTextField({
    Key? key,
    required this.outlineInputBorder,
  }) : super(key: key);

  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: TextDirection.ltr,
      keyboardType: TextInputType.number,
      style: const TextStyle(
        height: 1.2,
        fontFamily: "",
      ),
      decoration: InputDecoration(
        border: outlineInputBorder,
        errorBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        focusedErrorBorder: outlineInputBorder,
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        hintStyle: const TextStyle(
          height: 1.2,
          fontFamily: "",
        ),
        hintTextDirection: TextDirection.ltr,
        suffixIcon: const CountryCodeWidget(),
      ),
    );
  }
}

class CountryCodeWidget extends StatelessWidget {
  const CountryCodeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: 0.5,
      child: Container(
        // color: Colors.red,
        padding:  EdgeInsetsDirectional.only(end: AppSize.s10.w),
        // width: 50,
        child: Text(
          "+966",
          textDirection: TextDirection.ltr,
          style: context.titleL.copyWith(
            color: ColorsApp.mainColor,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
