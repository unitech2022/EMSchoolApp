import 'dart:math';

import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/helpers/spacing.dart';
import 'package:em_school/core/theming/styles.dart';
import 'package:em_school/features/common/models/schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utlis/app_model.dart';
import '../../../../bloc/student_cubit/student_cubit.dart';

class TablesScreen extends StatefulWidget {
  const TablesScreen({super.key});

  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {

  final _random = Random();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentCubit, StudentState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Text(screensItemsStudent[state.currentNavIndex].name,textAlign: TextAlign.start,style:TextStyles.textStyleFontLight25White ,),
              verticalSpace(15.h),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(vertical: 30.h,horizontal: 10.w),
                  itemCount: state.homeResponse!.scheduleResponses.length,

                  itemBuilder: (BuildContext context, int index) {

                    ScheduleResponse scheduleModel=state.homeResponse!.scheduleResponses[index];
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: context.width/6.3 ,
                          child: Text(isArabic()?scheduleModel.schedule.nameAr:
                            scheduleModel.schedule.nameEng
                          ,style: TextStyles.textStyleFontRegular14White,
                        )),
                        verticalSpace(20.h)
                        ,Column(
                          children: scheduleModel.sessions.map((e) =>
                              Container(
                                  alignment: Alignment.center,
                                  width: context.width/6.3,
                                  padding: EdgeInsets.symmetric(vertical: 40.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white,width: .5)
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 4.w),
                                  decoration: BoxDecoration(
                                    color: listColors[_random.nextInt(6)],
                                    borderRadius: BorderRadius.circular(5.r)
                                  ),
                                    child: Text(isArabic()?e.nameAr:e.nameEng,style: TextStyles.textStyleFontRegular17White,
                                    ),
                                  ))).toList(),
                        )
                      ],
                    );

                },

                ),
              ),
            ],
          ),
        );
      },
    );
  }
}