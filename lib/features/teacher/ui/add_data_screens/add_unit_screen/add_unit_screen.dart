import 'package:easy_localization/easy_localization.dart';
import 'package:em_school/core/enums/loading_status.dart';
import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/helpers/spacing.dart';
import 'package:em_school/core/layout/app_fonts.dart';
import 'package:em_school/core/theming/colors.dart';
import 'package:em_school/core/theming/styles.dart';
import 'package:em_school/core/widgets/circular_progress.dart';
import 'package:em_school/core/widgets/custom_button.dart';
import 'package:em_school/core/widgets/text_field_widget.dart';
import 'package:em_school/core/widgets/texts.dart';
import 'package:em_school/features/common/auth/ui/screens/register_screen/widgets/field_selector_register_widget.dart';
import 'package:em_school/features/common/models/course_model.dart';
import 'package:em_school/features/common/models/unit_model.dart';
import 'package:em_school/features/teacher/bloc/teacher_cubit/teacher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddUnitScreen extends StatefulWidget {
  final List<CourseModel> courses;
  final UnitModel? unitModel;
  // final List<List<UnitResponse>> units;
  const AddUnitScreen({super.key, required this.courses, this.unitModel});

  @override
  State<AddUnitScreen> createState() => _AddUnitScreenState();
}

class _AddUnitScreenState extends State<AddUnitScreen> {
  List<UnitModel> unitsResponse = [];
  final _nameArUnitController = TextEditingController();
  final _nameEngUnitController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.unitModel != null) {
      _nameArUnitController.text = widget.unitModel!.nameAr;
      _nameEngUnitController.text = widget.unitModel!.nameEng;
      TeacherCubit.get(context).courseModel = widget.courses
          .firstWhere((element) => element.id == widget.unitModel!.courseId);
    }
    // for (var element in widget.units) {
    //   for (var element in element) {
    //     unitsResponse.add(element.unitModel);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "اضافة وحدة",
          style: TextStyles.textStyleFontBold15whit,
        ),
      ),
      body: BlocBuilder<TeacherCubit, TeacherState>(
        builder: (contextBloc, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20).w,
              child: Column(children: [
                verticalSpace(10.h),

                ///  الكورس
                FieldSelectorRegisterWidget(
                  borderColor: const Color(0xFFB2B5B9),
                  onTap: () {
                    showBottomSelector(
                        list: widget.courses,
                        type: 1,
                        contextBloc: contextBloc);
                  },
                  value: TeacherCubit.get(context).courseModel == null
                      ? "اسم الكورس".tr()
                      : TeacherCubit.get(context).courseModel!.nameAr,
                  label: "اسم الكورس".tr(),
                ),

                verticalSpace(30.h),
                TextFormFieldWidget(
                  isObscureText: false,
                  controller: _nameArUnitController,
                  hintText: " اسم الوحدة باللغة العربية",
                  validator: (val) {},
                ),
                verticalSpace(30.h),
                TextFormFieldWidget(
                  isObscureText: false,
                  hintText: " اسم الوحدة باللغة الانجليزية",
                  validator: (val) {},
                  controller: _nameEngUnitController,
                ),
                verticalSpace(40.h),
                state.addCourseState == RequestState.loading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        title: widget.unitModel != null ? "تعديل" : "اضافة",
                        onPressed: () {
                          if (isValidateCourse(context)) {
                            if (widget.unitModel != null) {
                               TeacherCubit.get(context).updateUnit(
                                  context: context,
                                  id: widget.unitModel!.id,
                                  courseId:
                                      TeacherCubit.get(context).courseModel!.id,
                                  nameAr: _nameArUnitController.text,
                                  nameEng: _nameEngUnitController.text);
                            } else {
                              TeacherCubit.get(context).addUnit(
                                  context: context,
                                  courseId:
                                      TeacherCubit.get(context).courseModel!.id,
                                  nameAr: _nameArUnitController.text,
                                  nameEng: _nameEngUnitController.text);
                            }
                          }
                        })

                // verticalSpace(10.h),

                // FieldSelectorRegisterWidget(
                //   borderColor: const Color(0xFFB2B5B9),
                //   onTap: () {
                //     List<UnitModel> unitsOFCourse = [];
                //     if (TeacherCubit.get(context).courseModel != null) {}
                //     unitsOFCourse = unitsResponse
                //         .where((element) =>
                //             element.courseId ==
                //             TeacherCubit.get(context).courseModel!.id)
                //         .toList();
                //     if (unitsOFCourse.isNotEmpty) {
                //       showBottomSelector(
                //           list: TeacherCubit.get(context).courseModel == null
                //               ? []
                //               : unitsOFCourse,
                //           type: 1,
                //           contextBloc: contextBloc);
                //     }
                //   },
                //   value: TeacherCubit.get(context).unitModel == null
                //       ? "اسم الوحده".tr()
                //       : TeacherCubit.get(context).unitModel!.nameAr,
                //   label: "اسم الوحدة".tr(),
                // ),
              ]),
            ),
          );
        },
      ),
    );
  }

  bool isValidateCourse(BuildContext context) {
    if (TeacherCubit.get(context).courseModel == null) {
      showToast(msg: "اختار الكورس");
      return false;
    } else if (_nameArUnitController.text.isEmpty) {
      showToast(msg: "اكتب الاسم باللغة العربية");
      return false;
    } else if (_nameEngUnitController.text.isEmpty) {
      showToast(msg: "اكتب الاسم باللغة الانجليزية");
      return false;
    } else {
      return true;
    }
  }

  void showBottomSelector({list, type, contextBloc}) {
    showBottomSheetWidget(
        context,
        Container(
          padding:
              const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 20),
          decoration: const BoxDecoration(
              color: ColorsApp.boomSheetColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          height: context.height / 2,
          width: double.infinity,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (ctx, index) {
                      dynamic model = list[index];
                      return GestureDetector(
                        onTap: () {
                          TeacherCubit.get(contextBloc)
                              .changDataSelector(value: model, type: 1);
                          pop(context);
                        },
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(),
                          child: Row(
                            children: [
                              Texts(
                                  title: model.nameAr,
                                  textColor: Colors.white,
                                  family: AppFonts.innerMedium,
                                  size: 20.sp),
                            ],
                          ),
                        ),
                      );
                    }))
          ]),
        ));
  }
}
