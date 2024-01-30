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
import 'package:em_school/core/widgets/image_network_widget.dart';
import 'package:em_school/core/widgets/text_field_widget.dart';
import 'package:em_school/core/widgets/texts.dart';
import 'package:em_school/features/common/auth/ui/screens/register_screen/widgets/field_selector_register_widget.dart';
import 'package:em_school/features/common/models/course_model.dart';
import 'package:em_school/features/common/models/lesson_model.dart';
import 'package:em_school/features/common/models/unit_model.dart';
import 'package:em_school/features/teacher/bloc/teacher_cubit/teacher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddLessonScreen extends StatefulWidget {
  final List<CourseModel> courses;
  final List<List<UnitResponse>> units;
  final LessonModel? lessonModel;
  const AddLessonScreen(
      {super.key,
      required this.courses,
      required this.units,
      this.lessonModel});

  @override
  State<AddLessonScreen> createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLessonScreen> {
  List<UnitModel> unitsResponse = [];
  final _nameArLessonController = TextEditingController();
  final _nameEngLessonController = TextEditingController();
  final _descArLessonController = TextEditingController();
  final _descEngLessonController = TextEditingController();
  final _linkLessonController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameArLessonController.dispose();
    _nameEngLessonController.dispose();
    _descArLessonController.dispose();
    _descEngLessonController.dispose();
    _linkLessonController.dispose();
  }

  @override
  void initState() {
    super.initState();

    for (var element in widget.units) {
      for (var element in element) {
        unitsResponse.add(element.unitModel);
      }
    }

    if (widget.lessonModel != null) {
      _descArLessonController.text = widget.lessonModel!.descAr;
      _descEngLessonController.text = widget.lessonModel!.descEng;
      _nameArLessonController.text = widget.lessonModel!.nameAr;
      _nameEngLessonController.text = widget.lessonModel!.nameEng;
      _linkLessonController.text = widget.lessonModel!.linkVidio;
      TeacherCubit.get(context).unitModel = unitsResponse
          .firstWhere((element) => element.id == widget.lessonModel!.unitId);
      TeacherCubit.get(context).courseModel = widget.courses.firstWhere(
          (element) =>
              element.id == TeacherCubit.get(context).unitModel!.courseId);

      TeacherCubit.get(context).getImageLesson(widget.lessonModel!.image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "اضافة درس جديد",
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

                verticalSpace(10.h),
// الوحدة
                FieldSelectorRegisterWidget(
                  borderColor: const Color(0xFFB2B5B9),
                  onTap: () {
                    List<UnitModel> unitsOFCourse = [];
                    if (TeacherCubit.get(context).courseModel != null) {}
                    unitsOFCourse = unitsResponse
                        .where((element) =>
                            element.courseId ==
                            TeacherCubit.get(context).courseModel!.id)
                        .toList();
                    if (unitsOFCourse.isNotEmpty) {
                      showBottomSelector(
                          list: TeacherCubit.get(context).courseModel == null
                              ? []
                              : unitsOFCourse,
                          type: 2,
                          contextBloc: contextBloc);
                    }
                  },
                  value: TeacherCubit.get(context).unitModel == null
                      ? "اسم الوحده".tr()
                      : TeacherCubit.get(context).unitModel!.nameAr,
                  label: "اسم الوحدة".tr(),
                ),
                verticalSpace(30.h),
                // name lesson
                TextFormFieldWidget(
                  isObscureText: false,
                  controller: _nameArLessonController,
                  hintText: " اسم الدرس باللغة العربية",
                  validator: (val) {},
                ),

                // desc lesson
                verticalSpace(30.h),
                TextFormFieldWidget(
                  isObscureText: false,
                  hintText: " اسم الدرس باللغة الانجليزية",
                  validator: (val) {},
                  controller: _nameEngLessonController,
                ),

                verticalSpace(30.h),
                TextFormFieldAreaWidget(
                  isObscureText: false,
                  textInputType: TextInputType.multiline,
                  hintText: "شرح الدرس باللغة العربية",
                  validator: (val) {},
                  controller: _descArLessonController,
                ),
                verticalSpace(30.h),
                TextFormFieldAreaWidget(
                  textInputType: TextInputType.multiline,
                  isObscureText: false,
                  hintText: "شرح الدرس باللغة بالانجليزية",
                  validator: (val) {},
                  controller: _descEngLessonController,
                ),

                // link
                verticalSpace(30.h),
                TextFormFieldAreaWidget(
                  textInputType: TextInputType.multiline,
                  isObscureText: false,
                  hintText: "لينك الفيديو",
                  validator: (val) {},
                  controller: _linkLessonController,
                ),
                verticalSpace(30.h),
                // image lesson

                GestureDetector(
                  onTap: () async {
                    await TeacherCubit.get(context).uploadImage();
                  },
                  child: Column(
                    children: [
                      Text(
                        state.imageLesson == null
                            ? "اضافة صورة الدرس".tr()
                            : "تم اضافة الصورة".tr(),
                        style: TextStyles.textStyleFontMeduim19White.copyWith(
                            color: state.imageLesson == null
                                ? Colors.white
                                : Colors.green),
                      ),
                      verticalSpace(10.h),
                      state.imageLesson == null
                          ? Icon(
                              Icons.photo,
                              color: Colors.white,
                              size: 100.w,
                            )
                          : state.imageLessonState == RequestState.loading
                              ? const CustomCircularProgress(
                                  color: Colors.white,
                                )
                              : SizedBox(
                                  width: 250.w,
                                  height: 150.w,
                                  child: ImageNetworkWidget(
                                    image: state.imageLesson!,
                                    width: 250.w,
                                    height: 150.w,
                                  ))
                    ],
                  ),
                ),

                verticalSpace(40.h),
                state.addLessonState == RequestState.loading
                    ? const CustomCircularProgress()
                    : CustomButton(
                        title:widget.lessonModel==null? "اضافة":"تعديل",
                        onPressed: () async {
                          if (isValidateCourse(context,
                              imaLesson: state.imageLesson)) {
                          if(widget.lessonModel==null){
                              await TeacherCubit.get(context).addLesson(
                                context: context,
                                nameAr: _nameArLessonController.text,
                                nameEng: _nameEngLessonController.text,
                                descAr: _descArLessonController.text,
                                descEng: _descEngLessonController.text,
                                link: _linkLessonController.text,
                                image: state.imageLesson,
                                courseId:
                                    TeacherCubit.get(context).courseModel!.id,
                                unitId:
                                    TeacherCubit.get(context).unitModel!.id);
                       
                          }else {
                               await TeacherCubit.get(context).updateLesson(
                                context: context,
                                nameAr: _nameArLessonController.text,
                                nameEng: _nameEngLessonController.text,
                                descAr: _descArLessonController.text,
                                descEng: _descEngLessonController.text,
                                link: _linkLessonController.text,
                                image: state.imageLesson,
                             id: widget.lessonModel!.id,
                                unitId:
                                    TeacherCubit.get(context).unitModel!.id);
                          }
                          }
                        })
              ]),
            ),
          );
        },
      ),
    );
  }

  bool isValidateCourse(BuildContext context, {imaLesson}) {
    if (TeacherCubit.get(context).courseModel == null) {
      showToast(msg: "اختار الكورس");
      return false;
    } else if (TeacherCubit.get(context).unitModel == null) {
      showToast(msg: "اختار الوحدة");
      return false;
    } else if (_nameArLessonController.text.isEmpty) {
      showToast(msg: "اكتب الاسم باللغة العربية");
      return false;
    } else if (_nameEngLessonController.text.isEmpty) {
      showToast(msg: "اكتب الاسم باللغة الانجليزية");
      return false;
    } else if (_descArLessonController.text.isEmpty) {
      showToast(msg: "اكتب شرح الدرس باللغة العربية");
      return false;
    } else if (_descEngLessonController.text.isEmpty) {
      showToast(msg: "اكتب شرح الدرس باللغة الانجليزية");
      return false;
    } else if (_linkLessonController.text.isEmpty) {
      showToast(msg: "اكتب لينك الفيديو");
      return false;
    } else if (imaLesson == null) {
      showToast(msg: "اختار صورة الدرس");
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
                              .changDataSelector(value: model, type: type);
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
