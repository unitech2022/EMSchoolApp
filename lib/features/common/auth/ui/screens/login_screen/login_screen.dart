

import 'package:easy_localization/easy_localization.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/layout/app_fonts.dart';
import 'package:em_school/core/theming/styles.dart';
import 'package:em_school/core/widgets/app_text_button.dart';
import 'package:em_school/core/widgets/text_field_widget.dart';
import 'package:em_school/core/widgets/texts.dart';
import 'package:em_school/features/common/auth/cubit/auth_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui;
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theming/colors.dart';

class LoginScreen extends StatelessWidget {
  final String role;

  const LoginScreen({super.key, required this.role});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
    builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: Colors.transparent,

        ),
          body: SafeArea(
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 208.h),

              Text("آدخل رقم الهاتف".tr(), style: TextStyles.textStyleFontExtraBold27),
              SizedBox(height: 40.h),
              Directionality(
                textDirection:ui.TextDirection.ltr,

                child: SizedBox(
                  height: 80.h,
                  child: Row(
                    children: [
                      /// country code
                      GestureDetector(
                        onTap: (){},

                        child: Container(
                          height: double.infinity,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: ColorsApp.borderColor,width: 1)
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 13.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/icons/flag.svg"),
                             horizontalSpace(5.w),
                             Texts(title: "+20", family: AppFonts.innerExtraBold, size: 17.sp,textColor: Colors.white),
                              horizontalSpace(5.w),
                              const Icon(Icons.arrow_drop_down_outlined,color: Color(0xffA1A3AF),)
                            ],
                          ),

                        ),
                      ),
                      horizontalSpace(20),
                      Expanded(child: TextFormFieldWidget(
                        controller: AuthCubit.get(context).phoneController,
                        hintText: "رقم الهاتف".tr(), validator: (value){

                      },isObscureText:false,
                        textInputType: TextInputType.number,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 30.h),

                      ))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.h),

              AppTextButton(buttonText: "دخول".tr(), textStyle: TextStyles.textStyleFontExtraBold24White, onPressed: (){
                if(AuthCubit.get(context).phoneController.text.isEmpty){
showToast(msg: "آدخل رقم الهاتف".tr(),color: Colors.red);
                }else{
                  AuthCubit.get(context).checkUserName(context: context
                      ,phone:"+20${AuthCubit.get(context).phoneController.text}",
                      role: role);
                }
              },

              )
            ],
          ),
        ),
      )));
    },
);
  }
}
