import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/theming/styles.dart';

class ContainerTypeAccount extends StatelessWidget {
  final String name;
  final String image;
  final int type;
  final void Function() onTap;

  const ContainerTypeAccount({super.key, required this.name, required this.image,required this.onTap,this.type=0});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),


        ),
        height:206.h,width:253.w,
        child: Stack(
          children: [

            ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
                child: Image.asset(image, height:double.infinity,width:double.infinity,fit: BoxFit.fill,)),

            Positioned(
                bottom:type==0? 10.h:null,
                top:type==0?null :25.h,
                right: 13.w,
                child: Text(name,style: TextStyles.textStyleFontExtraBold29)),

          ],
        ),


      ),
    );
  }
}