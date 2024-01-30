import 'package:em_school/core/enums/loading_status.dart';
import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/theming/styles.dart';
import 'package:em_school/core/utlis/app_model.dart';
import 'package:em_school/core/widgets/custom_button.dart';
import 'package:em_school/core/widgets/text_field_widget.dart';
import 'package:em_school/features/student/ui/subject_details_screen/components/lessons_list_widget.dart';
import 'package:em_school/features/teacher/bloc/teacher_cubit/teacher_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/widgets/circular_progress.dart';
import '../../../../../common/models/course_model.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({super.key});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  bool expanded = false;
  int? currentIndexCourse = 0;
  final _nameArCourseController = TextEditingController();
  final _nameEngCourseController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _nameArCourseController.dispose();
    // _nameEngCourseController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<TeacherCubit, TeacherState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  screensItemsTeacher[state.currentNavIndex].name,
                  textAlign: TextAlign.start,
                  style: TextStyles.textStyleFontLight25White,
                ),
                verticalSpace(25.h),
                ExpansionTile(
                  key: GlobalKey(),
                  childrenPadding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  tilePadding: EdgeInsets.zero,
                  initiallyExpanded: expanded,
                  onExpansionChanged: (value) {
                    expanded = value;
                  },
                  collapsedBackgroundColor: Colors.transparent,
                  collapsedIconColor: Colors.white,
                  title: state.homeTeacherResponse!.courses.isEmpty
                      ? const SizedBox()
                      : Text(
                          state.homeTeacherResponse!
                              .courses[currentIndexCourse!].nameAr,
                          style: TextStyles.textStyleFontBold22White,
                        ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r)),
                  children: List.generate(
                      state.homeTeacherResponse!.courses.length, (index) {
                    CourseModel e = state.homeTeacherResponse!.courses[index];
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.white, width: .5))),
                      child: ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -4),
                        minVerticalPadding: 0.0,
                        onTap: () {
                          setState(() {
                            expanded = !expanded;
                            currentIndexCourse = index;
                          });
                        },
                        title: Text(
                          e.nameAr,
                          style: TextStyles.textStyleFontMeduim20White,
                        ),

                        trailing: RowEditorWidget(
                          onUpdate: () {
                            _nameArCourseController.text = e.nameAr;
                            _nameEngCourseController.text = e.nameEng;
                            bottomSheetUpdateCourse(context, courseId: e.id);
                          },
                          onDelete: () {
                            showDialogDeleteData(
                                context: context,
                                value: e.nameAr,
                                onConfiem: () {
                                  pop(context);
                                  TeacherCubit.get(context).deleteCourse(
                                      context: context, courseId: e.id);
                                });
                          },
                        ),
                        // trailing: Icon(
                        //   Icons.check,
                        //   color: currentCourse == null ||
                        //           currentCourse!.id != e.id
                        //       ? Colors.transparent
                        //       : Colors.green,
                        // ),
                      ),
                    );
                  }).toList(),
                ),
                verticalSpace(20.h),
                LessonsListWidget(
                  list: state
                      .homeTeacherResponse!.unitResponses[currentIndexCourse!],
                )
              ],
            ),
          ),
        );
      },
    ));
  }

  void bottomSheetUpdateCourse(BuildContext context, {courseId}) {
    return showBottomSheetWidget(context,
        BlocBuilder<TeacherCubit, TeacherState>(
      builder: (contextBloc, state) {
        return StatefulBuilder(
          builder: (BuildContext context,
              void Function(void Function()) setStateSheet) {
            return Container(
              padding: const EdgeInsets.only(
                  top: 40, left: 30, right: 30, bottom: 20),
              decoration: const BoxDecoration(
                  color: ColorsApp.boomSheetColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              height: context.height / 2,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // icon back
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          pop(context);
                        },
                      ),
                      const Spacer(),
                      Text(
                        "اضافة",
                        style: TextStyles.textStyleFontBold22White,
                      ),
                      const Spacer()
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // body ======================================================================

                  Column(
                    children: [
                      TextFormFieldWidget(
                        isObscureText: false,
                        backgroundColor: ColorsApp.boomSheetColor,
                        hintText: " اسم الكورس باللغة العربية",
                        validator: (val) {},
                        controller: _nameArCourseController,
                      ),
                      verticalSpace(20.h),
                      TextFormFieldWidget(
                        isObscureText: false,
                        backgroundColor: ColorsApp.boomSheetColor,
                        hintText: " اسم الكورس باللغة الانجليزية",
                        validator: (val) {},
                        controller: _nameEngCourseController,
                      ),
                      verticalSpace(20.h),
                      state.addCourseState == RequestState.loading
                          ? const CustomCircularProgress()
                          : CustomButton(
                              title: "تعديل",
                              onPressed: () {
                                if (isValidateCourse(context)) {
                                  TeacherCubit.get(context).updateCourse(
                                      context: context,
                                      courseId: courseId,
                                      nameAr: _nameArCourseController.text,
                                      nameEng: _nameEngCourseController.text);
                                }
                              })
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    ));
  }

  bool isValidateCourse(BuildContext context) {
    if (_nameArCourseController.text.isEmpty) {
      showToast(msg: "اكتب الاسم باللغة العربية");
      return false;
    } else if (_nameEngCourseController.text.isEmpty) {
      showToast(msg: "اكتب الاسم باللغة الانجليزية");
      return false;
    } else {
      return true;
    }
  }
}

class RowEditorWidget extends StatelessWidget {
  final void Function() onUpdate;
  final void Function() onDelete;
  const RowEditorWidget({
    super.key,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: onUpdate,
            icon: const Icon(
              FontAwesomeIcons.penToSquare,
              color: Colors.green,
            )),
        IconButton(
            onPressed: onDelete,
            icon: const Icon(
              FontAwesomeIcons.trash,
              color: Colors.red,
            )),
      ],
    );
  }
}
