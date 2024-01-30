import 'package:em_school/core/helpers/spacing.dart';
import 'package:em_school/core/theming/colors.dart';
import 'package:em_school/core/theming/styles.dart';
import 'package:em_school/core/utlis/app_model.dart';
import 'package:em_school/core/widgets/image_network_widget.dart';
import 'package:em_school/features/common/models/home_teacher_response.dart';
import 'package:em_school/features/teacher/bloc/teacher_cubit/teacher_cubit.dart';
import 'package:em_school/features/teacher/ui/navigation_teacher_screen/screens_nav/home_teacher_screen/home_teacher_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<TeacherCubit, TeacherState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              screensItemsTeacher[state.currentNavIndex].name,
              textAlign: TextAlign.start,
              style: TextStyles.textStyleFontLight25White,
            ),
            verticalSpace(25.h),
            // students
            Container(
              constraints: const BoxConstraints.tightFor(),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              padding: const EdgeInsets.all(16).w,
              decoration: BoxDecoration(
                  color: ColorsApp.boomSheetColor,
                  borderRadius: BorderRadius.circular(10.r)),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: state.homeTeacherResponse!.students.length,
                itemBuilder: (context, index) {
                  StudentResponse studentResponse =
                      state.homeTeacherResponse!.students[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 5.h),
                    child: Row(
                      children: [
                        // image
                        Container(
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15).r,
                            child: ImageNetworkWidget(
                                image:
                                    studentResponse.student.profileImage ?? "",
                                errorWidget: Image.asset("assets/images/e.png"),
                                height: 30.h,
                                width: 30.w),
                          ),
                        ),
                        horizontalSpace(10.w),
                        Expanded(
                          child: Text(
                            studentResponse.student.fullName,
                            style: TextStyles.textStyleFontRegular16White
                                .copyWith(overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        horizontalSpace(10.w),
                        Row(
                          children: [
                            RowIconLessonnDetails(
                              value: studentResponse.exercises
                                  .where((element) =>
                                      element.result <
                                      (element.finalDegree / 2))
                                  .length
                                  .toString(),
                              icon: "assets/icons/degree.svg",
                              padding: 10.w,
                            ),
                            horizontalSpace(15.w),
                            RowIconLessonnDetails(
                              value: studentResponse.exercises
                                  .where((element) =>
                                      element.result ==
                                      (element.finalDegree / 2))
                                  .length
                                  .toString(),
                              icon: "assets/icons/degree.svg",
                              iconColor: const Color(0xffDB7F00),
                              padding: 10.w,
                            ),
                            horizontalSpace(15.w),
                            RowIconLessonnDetails(
                              value: studentResponse.exercises
                                  .where((element) =>
                                      element.result >
                                      (element.finalDegree / 2))
                                  .length
                                  .toString(),
                              icon: "assets/icons/degree.svg",
                              iconColor: const Color(0xff13AC54),
                              padding: 10.w,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.white,
                  height: 1,
                ),
              ),
            )
          ],
        );
      },
    ));
  }
}
