

import 'package:easy_localization/easy_localization.dart';

import 'package:em_school/core/theming/styles.dart';
import 'package:em_school/core/widgets/app_text_button.dart';
import 'package:em_school/core/widgets/text_field_widget.dart';

import 'package:em_school/features/common/auth/cubit/auth_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class LoginWithPasswordScreen extends StatelessWidget {
  final String role,phone;

  const LoginWithPasswordScreen({super.key, required this.role, required this.phone});




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
        child: Column(
          children: [

            SizedBox(height: 208.h),

            Text("آدخل الرقم السري".tr(), style: TextStyles.textStyleFontExtraBold27),
            SizedBox(height: 40.h),
            Expanded(child: TextFormFieldWidget(
              controller: AuthCubit.get(context).passwordController,
              hintText: "الرقم السري".tr(), validator: (value){

            },isObscureText:false,
              textInputType: TextInputType.text,
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 30.h),

            )),
            SizedBox(height: 40.h),

            AppTextButton(buttonText: "دخول".tr(), textStyle: TextStyles.textStyleFontExtraBold24White, onPressed: (){
              if(AuthCubit.get(context).passwordController.text.isEmpty){

              }else{
                AuthCubit.get(context).loginUser(context: context,phone:phone,deviceToken: "role",
                code: AuthCubit.get(context).passwordController.text
                );
              }
            },

            )
          ],
        ),
      )));
    },
);
  }
}
