import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/styles.dart';

class FieldSelectorRegisterWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String value,label;
  final Color borderColor;
  const FieldSelectorRegisterWidget({super.key, required this.onTap,required this.label,required this.value,
    required this.borderColor
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 85.h,

            padding:  EdgeInsets.only(left: 20.w,right: 20.h),
            margin:  EdgeInsets.only(top: 22.h),
            decoration: BoxDecoration(
              border: Border.all(
                  color:borderColor, width: 1.3),
              borderRadius: BorderRadius.circular(12.r),
              shape: BoxShape.rectangle,
            ),
            alignment: Alignment.center,
            child: Row
              (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(value.tr() , style:TextStyles.textStyleFontBold20White,),
                const Icon(Icons.arrow_drop_down_sharp,color: Color(0xffA1A3AF))
              ],
            ),
          ),
          Positioned(
            right: 10.w,
            top: 15.h,
            child: Container(
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              color:ColorsApp.backgroundColor,
              child:  Text(
                label.tr(),
                style:TextStyles.textStyleFontExtraBold12White ,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
