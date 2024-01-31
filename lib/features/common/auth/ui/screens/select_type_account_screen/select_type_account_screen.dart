import 'package:easy_localization/easy_localization.dart';
import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/utlis/app_model.dart';
import 'package:em_school/features/common/auth/ui/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theming/styles.dart';
import 'widgets/container_type_account.dart';

class SelectTypeAccountScreen extends StatelessWidget {
  const SelectTypeAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
              child: Column(
      children: [
        SizedBox(height: 20.h),
        GestureDetector(
          onTap: () {
            showChangeLangDialog(contextBloc: context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                Text(
               "العربية".tr()
                
                , style: TextStyles.textStyleFontExtraBold27),
            ],
          ),
        ),
        SizedBox(height: 7.h),
        Text("عرف نفسك".tr(),style: TextStyles.textStyleFontExtraBold27),
        SizedBox(height: 38.h),

         ContainerTypeAccount(image:"assets/images/student.png",name:"طالب".tr(),onTap: (){
           context.navigatePush(LoginScreen(role: AppModel.studentRole,));


        },),

        SizedBox(height: 30.h),
          ContainerTypeAccount(image:"assets/images/teacher.png",name:"مدرس".tr(),onTap: (){
            context.navigatePush(LoginScreen(role: AppModel.teacherRole,));
        },),
        SizedBox(height: 30.h),
        ContainerTypeAccount(image:"assets/images/parent.png",type: 1,name:"ولي آمر".tr(),onTap: (){

        },),



      ],
    ),
            )));
  }
}


