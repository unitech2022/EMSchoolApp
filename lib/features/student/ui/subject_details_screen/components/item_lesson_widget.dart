import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/theming/styles.dart';
import 'package:em_school/features/student/bloc/lesson_cubit/lesson_cubit.dart';
import 'package:em_school/features/student/ui/lesson_details_screen/lesson_details_screen.dart';
import 'package:em_school/features/teacher/bloc/teacher_cubit/teacher_cubit.dart';
import 'package:em_school/features/teacher/ui/add_data_screens/add_lesson_screen/add_lesson_screen.dart';
import 'package:em_school/features/teacher/ui/navigation_teacher_screen/screens_nav/lessons_screen/lessons_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../common/models/lesson_model.dart';

class ItemLessonWidget extends StatelessWidget {
  final List<LessonModel> lessons;

  const ItemLessonWidget({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherCubit, TeacherState>(
      builder: (context, state) {
        return ListView(
          shrinkWrap: true,
          children: lessons
              .map((e) => GestureDetector(
                    onTap: () {
                      context.navigatePush(BlocProvider<LessonCubit>(
                        create: (context) => LessonCubit(),
                        child: LessonDetailsScreen(lessonId: e.id),
                      ));
                    },
                    child: SizedBox(
                      height: 70.h,
                      width: context.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 20.h,
                                      width: 20.w,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color: ColorsApp.blueColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Container(
                                        height: 5.h,
                                        width: 5.w,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      )),
                                  e == lessons.elementAt(lessons.length - 1)
                                      ? const SizedBox()
                                      : Container(
                                          height: 45.h,
                                          width: 3.w,
                                          color: ColorsApp.blueColor,
                                        ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(isArabic()?e.nameAr:e.nameEng,
                                          style: TextStyles
                                              .textStyleFontMeduim20White),
                                     isStudennt()?const SizedBox():   RowEditorWidget(
                                        onUpdate: () {
                                          context.navigatePush(AddLessonScreen(
                                              courses: state
                                                  .homeTeacherResponse!.courses,
                                              units: state.homeTeacherResponse!
                                                  .unitResponses,
                                                  lessonModel:e));
                                        },
                                        onDelete: () {
                                          showDialogDeleteData(
                                              context: context,
                                              value: e.nameAr,
                                              onConfiem: () {
                                                pop(context);
                                                TeacherCubit.get(context).deleteLesson(
                                                    context: context, lessonId: e.id);
                                              });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}
