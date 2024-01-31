import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/theming/colors.dart';
import 'package:em_school/features/common/models/alert_model.dart';
import 'package:em_school/features/teacher/bloc/teacher_cubit/teacher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theming/styles.dart';
import '../../../../../../core/utlis/app_model.dart';
import '../../../../../../core/widgets/image_network_widget.dart';

class NotificationsTeacherScreen extends StatelessWidget {
  const NotificationsTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherCubit, TeacherState>(
      builder: (context, state) {
        return Scaffold(

          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(screensItemsStudent[state.currentNavIndex].name,
                textAlign: TextAlign.center,
                style: TextStyles.textStyleFontLight25White,),
              verticalSpace(15.h),
              Expanded(child: ListView.builder(
                  itemCount: state.homeTeacherResponse!.alerts.length,
                  padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                  itemBuilder: (ctx,index){
                    AlertModel alert=state.homeTeacherResponse!.alerts[index];
                return Container(
                  padding: const EdgeInsets.all(20).w,
                  margin: EdgeInsets.only(bottom: 10.h),
                  decoration:  BoxDecoration(
                    color: ColorsApp.boomSheetColor,
                    borderRadius: BorderRadius.circular(10.r)
                  ),
                  width: double.infinity,

                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle
                        ),
                        height:60.h,
                        width: 60.h
                        ,child: ImageNetworkWidget(
                    height:60.h,
                    width: 60.h,
                        errorWidget: Image.asset("assets/images/e.png",
                            height:60.h,
                            width: 60.h
                            ,fit: BoxFit.contain
                        ),
                        image: "",fit: BoxFit.contain,
                      ),
                      ),
                      horizontalSpace(18.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(isArabic()?alert.titleAr:alert.titleEng,style: TextStyles.textStyleFontSemiBold23White,),
                            verticalSpace(10.h),
                            Text(alert.descriptionAr
                              ,maxLines: 2
                              ,style: TextStyles.textStyleFontMeduim21grey,),
                          ],
                        ),
                      ),

                      Text(alert.createdAt.split("T")[0],style: TextStyles.textStyleFontNormal10grey,)

                    ],
                  ),


                );
              }))

            ],
          ),
        );
      },
    );
  }
}
