import 'package:easy_localization/easy_localization.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/helpers/spacing.dart';
import 'package:em_school/core/theming/colors.dart';
import 'package:em_school/core/theming/styles.dart';
import 'package:em_school/core/utlis/app_model.dart';
import 'package:em_school/core/widgets/image_network_widget.dart';
import 'package:em_school/features/common/models/home_teacher_response.dart';
import 'package:em_school/features/teacher/bloc/teacher_cubit/teacher_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../student/ui/navigation_student_screen/screens_nav/home_screen_student/home_screen_student.dart';

class HomeTeacherScreen extends StatelessWidget {
  const HomeTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<TeacherCubit, TeacherState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  screensItemsTeacher[state.currentNavIndex].name,
                  textAlign: TextAlign.start,
                  style: TextStyles.textStyleFontLight25White,
                ),
                verticalSpace(25.h),
                // lessons
                 TextTitle(
                  title: "الدروس".tr(),
                ),
                verticalSpace(15.h),
                LessonsListWidget(list: state.homeTeacherResponse!.lessons),
                verticalSpace(35.h),
                // students

                 TextTitle(
                  title: "الطلاب".tr(),
                ),
                verticalSpace(15.h),
                StudentsListWidget(list: state.homeTeacherResponse!.students)
              ],
            ),
          ),
        );
      },
    ));
  }
}

class StudentsListWidget extends StatelessWidget {
  final List<StudentResponse> list;
  const StudentsListWidget({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20).w,
      decoration: BoxDecoration(
          color: ColorsApp.boomSheetColor,
          borderRadius: BorderRadius.circular(10.r)),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          StudentResponse studentResponse = list[index];
          return Row(
            children: [
              // image
              Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15).r,
                  child: ImageNetworkWidget(
                      image: studentResponse.student.profileImage ?? "",
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
              Expanded(
                child: RowIconLessonnDetails(
                  value: studentResponse.exercises.length.toString(),
                  icon: "assets/icons/degree.svg",
                  padding: 10.w,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Colors.white,
          height: 1,
        ),
      ),
    );
  }
}

class LessonsListWidget extends StatelessWidget {
  final List<LessonTeacherResponse> list;
  const LessonsListWidget({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20).w,
      decoration: BoxDecoration(
          color: ColorsApp.boomSheetColor,
          borderRadius: BorderRadius.circular(10.r)),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          LessonTeacherResponse lesson = list[index];
          return Row(
            children: [
              // image
              Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15).r,
                  child: ImageNetworkWidget(
                      image: lesson.lesson.image, height: 30.h, width: 30.w),
                ),
              ),
              horizontalSpace(10.w),
              Expanded(
                child: Text(
                  isArabic()?lesson.lesson.nameAr:lesson.lesson.nameEng,
                  style: TextStyles.textStyleFontRegular16White
                      .copyWith(overflow: TextOverflow.ellipsis),
                ),
              ),
              horizontalSpace(10.w),
              RowIconLessonnDetails(
                value: lesson.lesson.views.toString(),
                icon: "assets/icons/Eye.svg",
              ),
              horizontalSpace(5.w),
              RowIconLessonnDetails(
                value: lesson.lesson.liks.toString(),
                icon: "assets/icons/lik.svg",
              ),
              horizontalSpace(5.w),
              RowIconLessonnDetails(
                value: lesson.successfuly.toString(),
                icon: "assets/icons/succ.svg",
              ),
              horizontalSpace(5.w),
              RowIconLessonnDetails(
                value: lesson.comments.length.toString(),
                icon: "assets/icons/comment.svg",
              )
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}

class RowIconLessonnDetails extends StatelessWidget {
  final String icon, value;
  final double? padding;
  final Color? iconColor;
  const RowIconLessonnDetails(
      {super.key,
      required this.icon,
      required this.value,
      this.padding,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyles.textStyleFontMeduim19White,
        ),
        horizontalSpace(padding ?? 5.w),
        SvgPicture.asset(
          icon,
          colorFilter: iconColor != null
              ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
              : null,
        ),
      ],
    );
  }
}
