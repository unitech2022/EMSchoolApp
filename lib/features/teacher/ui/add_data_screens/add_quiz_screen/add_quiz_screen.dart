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
import 'package:em_school/features/common/models/answer_for_add.dart';
import 'package:em_school/features/teacher/bloc/teacher_cubit/teacher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// in morrning
class AddQuizScreen extends StatefulWidget {
  final int lessonId;

  const AddQuizScreen({
    super.key,
    required this.lessonId,
  });

  @override
  State<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  final _nameArQuiznController = TextEditingController();
  final _nameEngQuizController = TextEditingController();

  List<AnswerForAdd> answers = [];
  final List<TextEditingController> _controllersAr = [];

  final List<TextEditingController> _controllersEng = [];
  int correctId = 0;

  @override
  void dispose() {
    super.dispose();
    _nameArQuiznController.dispose();
    _nameEngQuizController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  bool isImage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "اضافة سؤال جديد".tr(),
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

                // name lesson
                TextFormFieldWidget(
                  isObscureText: false,
                  controller: _nameArQuiznController,
                  hintText: " السؤال باللغة العربية".tr(),
                  validator: (val) {},
                ),

                // desc lesson
                verticalSpace(30.h),
                TextFormFieldWidget(
                  isObscureText: false,
                  hintText: " السؤال باللغة الانجليزية".tr(),
                  validator: (val) {},
                  controller: _nameEngQuizController,
                ),

                verticalSpace(30.h),

                // check box
                Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Colors.white,
                  ),
                  child: CheckboxListTile(
                    checkColor: Colors.white,
                    title: Text(
                      "اضافة صورة".tr(),
                      style: TextStyles.textStyleFontMeduim19White,
                    ),
                    value: isImage,
                    onChanged: (newValue) {
                      setState(() {
                        isImage = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
                verticalSpace(20.h),
                // image lesson

                !isImage
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () async {
                          await TeacherCubit.get(context).uploadImage();
                        },
                        child: Column(
                          children: [
                            Text(
                              state.imageLesson == null
                                  ? "اضافة صورة الدرس".tr()
                                  : "تم اضافة الصورة".tr(),
                              style: TextStyles.textStyleFontMeduim19White
                                  .copyWith(
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
                verticalSpace(!isImage ? 0 : 20.h),

                /// answers
                MaterialButton(
                  onPressed: () {
                    if (_controllersAr.length < 3) {
                      _controllersAr.add(TextEditingController());
                      _controllersEng.add(TextEditingController());
                      setState(() {});
                    }
                  },
                  child: Row(children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    horizontalSpace(20.w),
                    Text(
                      "اضافة اجابة".tr(),
                      style: TextStyles.textStyleFontMeduim19White,
                    )
                  ]),
                ),
                verticalSpace(20.h),

                // fields Answers
                Column(
                  children: List.generate(
                      _controllersAr.length,
                      (index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormFieldWidget(
                                    hintText: "الاجابة بالعربية".tr(),
                                    validator: (val) {},
                                    isObscureText: false,
                                    controller: _controllersAr[index],
                                  ),
                                ),
                                horizontalSpace(
                                  10.w,
                                ),
                                Expanded(
                                  child: TextFormFieldWidget(
                                    hintText: "الاجابة بالانجليزية".tr(),
                                    isObscureText: false,
                                    validator: (val) {},
                                    controller: _controllersEng[index],
                                  ),
                                ),
                                horizontalSpace(
                                  10.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    correctId = index;
                                    setState(() {});
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "الصحيحة".tr(),
                                        style:
                                            TextStyles.textStyleFontBold18whit,
                                      ),
                                      verticalSpace(10.h),
                                      Container(
                                        height: 25.w,
                                        width: 25.w,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: correctId == index
                                                ? ColorsApp.mainColor
                                                : Colors.transparent,
                                            border: Border.all(
                                                width: 1,
                                                color: ColorsApp.mainColor)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                ),

                verticalSpace(40.h),
                state.addLessonState == RequestState.loading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        title: "اضافة".tr(),
                        onPressed: () async {
                          answers = [];
                          for (var i = 0; i < _controllersAr.length; i++) {
                            answers.add(AnswerForAdd(
                                _controllersAr[i].text,
                                _controllersEng[i].text,
                                correctId == i ? true : false));
                          }
                          if (isValidate(context,imaLesson: state.imageLesson)) {
                            TeacherCubit.get(context).addQuiz(
                              
                              answers,descAr: _nameArQuiznController.text,
                              descEng: _nameEngQuizController.text,
                              type: isImage?1:0,
                              lessonId: widget.lessonId,
                              context: context,
                              image: isImage?state.imageLesson:"not"
                            );
                          }

                          // if (isValidateCourse(context,
                          //     imaLesson: state.imageLesson)) {
                          // await TeacherCubit.get(context).addLesson(
                          //     context: context,
                          //     nameAr: _nameArLessonController.text,
                          //     nameEng: _nameEngLessonController.text,
                          //     descAr: _descArLessonController.text,
                          //     descEng: _descEngLessonController.text,
                          //     link: _linkLessonController.text,
                          //     image: state.imageLesson,
                          //     courseId:
                          //         TeacherCubit.get(context).courseModel!.id,
                          //     unitId:
                          //         TeacherCubit.get(context).unitModel!.id);
                          // }
                        })
                  , verticalSpace(40.h),
              
              ]),
            ),
          );
        },
      ),
    );
  }

  bool isValidate(BuildContext context, {imaLesson}) {
    if (_nameArQuiznController.text.isEmpty) {
      showToast(msg: "اكتب السؤال باللغة العربية".tr());
      return false;
    } else if (_nameEngQuizController.text.isEmpty) {
      showToast(msg: "اكتب السؤال باللغة الانجليزية".tr());
      return false;
    } else if (isImage && imaLesson == null) {
      showToast(msg: "اختار صورة الدرس".tr());
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
