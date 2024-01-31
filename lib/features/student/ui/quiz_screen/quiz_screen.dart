import 'package:easy_localization/easy_localization.dart';
import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/helpers/spacing.dart';
import 'package:em_school/core/theming/colors.dart';
import 'package:em_school/core/widgets/custom_button.dart';
import 'package:em_school/core/widgets/image_network_widget.dart';
import 'package:em_school/features/common/models/lesson_model.dart';
import 'package:em_school/features/common/models/quiz_model.dart';
import 'package:em_school/features/student/bloc/lesson_cubit/lesson_cubit.dart';
import 'package:em_school/features/student/ui/quiz_screen/result_screen/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theming/styles.dart';

class QuizScreen extends StatefulWidget {
  final LessonDetailsResponse lessonDetailsResponse;
  final int? subjectId;

  const QuizScreen(
      {super.key, required this.lessonDetailsResponse, this.subjectId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  PageController controller =
      PageController(viewportFraction: 1, keepPage: true);

  int result = 0;
  int countAnswered = 0;
  bool isEndPage = false;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant QuizScreen oldWidget) {
    // TODO: implement didUpdateWidget

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LessonCubit.get(context).startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonCubit, LessonState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  LessonCubit.get(context).cancelTimer();
                  context.navigatePop();
                },
              ),
              title: Row(
                children: [
                  Text(
                    "اختبار".tr(),
                    style: TextStyles.textStyleFontBold22White,
                  ),
                  horizontalSpace(10.w),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xff6C1EEA),
                          borderRadius: BorderRadius.circular(35.r)),
                      child: Text(
                        isArabic()?
                        widget.lessonDetailsResponse.lesson.nameAr:
                        widget.lessonDetailsResponse.lesson.nameEng,
                        style: TextStyles.textStyleFontBold22White,
                      )),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20).w,
              child: Column(
                children: [
                  /// result
                  ResultAndQuizesWidget(
                      quiesz: widget.lessonDetailsResponse.quizes.length,
                      result: result,
                      timer: state.timer,
                      countAnswered: countAnswered),
                  verticalSpace(29.h),
                  Expanded(
                      child: PageView(
                    controller: controller,
                    onPageChanged: (index) {
                    
                      if (index + 1 ==
                          widget.lessonDetailsResponse.quizes.length) {
                        isEndPage = true;
                      } else {
                        isEndPage = false;
                      }
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    children: widget.lessonDetailsResponse.quizes
                        .map((e) => getQuizWidget(
                            e, state.idSelected, state.timer,
                            contextBloc: context))
                        .toList(),
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getQuizWidget(QuizResponse e, int idSelected, int time,
      {contextBloc}) {
    switch (e.quiz.type) {
      case 0:
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(35).w,
                margin: EdgeInsets.only(bottom: 20.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: ColorsApp.boomSheetColor),
                child: Text(isArabic()?e.quiz.descAr:e.quiz.descEng,
                    style: TextStyles.textStyleFontExteraBold22White),
              ),
              verticalSpace(20.h),

              /// options
              Column(
                children: e.answers
                    .map((e) => GestureDetector(
                          onTap: () async {
                            if (idSelected == 0) {
                              await LessonCubit.get(contextBloc)
                                  .playSound(file: "sounds/selected.mp3");
                              if (e.isCorrect) {
                                result++;
                              }
                              LessonCubit.get(contextBloc).currentAnswer(e.id);
                            } else {}
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: const EdgeInsets.all(25).w,
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: ColorsApp.boomSheetColor,
                                border: Border.all(
                                    color: idSelected == 0
                                        ? const Color(0xff1A61A2)
                                        : e.isCorrect
                                            ? Colors.green
                                            : Colors.red,
                                    width: 3)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(isArabic()?e.textAr:e.textEng,
                                    style: TextStyles
                                        .textStyleFontExteraBold22White),
                                idSelected == 0
                                    ? const SizedBox()
                                    : SvgPicture.asset(e.isCorrect
                                        ? "assets/icons/success.svg"
                                        : "assets/icons/error.svg")
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
              verticalSpace(30.h),
              // buttons
              CustomButton(
                  fontSize: 25.sp,
                  height: 60.h,
                  title: isEndPage ? "شوف النتيجة".tr() : "السؤال التالي".tr(),
                  backgroundColor: Colors.green,
                  onPressed: () async {
                    if (isEndPage) {
                      LessonCubit.get(context).cancelTimer();
                      context.navigatePush(BlocProvider(
                        create: (context) => LessonCubit(),
                        child: ResultScreen(
                            result: result,
                            time: time,
                            sujectId: widget.subjectId,
                            lessonDetailsResponse: widget.lessonDetailsResponse,
                            countQuiz:
                                widget.lessonDetailsResponse.quizes.length),
                      ));
                    } else {
                      if (idSelected != 0) {
                        countAnswered++;
                        controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.decelerate,
                        );
                        LessonCubit.get(contextBloc).currentAnswer(0);
                      } else {
                        showToast(msg: "اختار اجابة".tr(), color: Colors.red);
                      }
                    }
                  })
            ],
          ),
        );

      default:
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15).w,
                margin: EdgeInsets.only(bottom: 20.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: ColorsApp.boomSheetColor),
                child: ImageNetworkWidget(
                  image: e.quiz.file!,
                  height: 120.h,
                  width: 200.w,
                  fit: BoxFit.contain,
                ),
              ),
              verticalSpace(10.h),
              Text(isArabic()?e.quiz.descAr:e.quiz.descEng,
                  style: TextStyles.textStyleFontExteraBold22White),
              verticalSpace(30.h),

              /// options
              Column(
                children: e.answers
                    .map((e) => GestureDetector(
                          onTap: () async {
                            if (idSelected == 0) {
                              await LessonCubit.get(contextBloc)
                                  .playSound(file: "sounds/selected.mp3");
                              if (e.isCorrect) {
                                result++;
                              }
                              LessonCubit.get(contextBloc).currentAnswer(e.id);
                            } else {}
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: const EdgeInsets.all(25).w,
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: ColorsApp.boomSheetColor,
                                border: Border.all(
                                    color: idSelected == 0
                                        ? const Color(0xff1A61A2)
                                        : e.isCorrect
                                            ? Colors.green
                                            : Colors.red,
                                    width: 3)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(isArabic()?e.textAr:e.textEng,
                                    style: TextStyles
                                        .textStyleFontExteraBold22White),
                                idSelected == 0
                                    ? const SizedBox()
                                    : SvgPicture.asset(e.isCorrect
                                        ? "assets/icons/success.svg"
                                        : "assets/icons/error.svg")
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
              verticalSpace(30.h),
              CustomButton(
                  fontSize: 25.sp,
                  height: 60.h,
                  title: isEndPage ? "شوف النتيجة".tr() : "السؤال التالي".tr(),
                  backgroundColor: Colors.green,
                  onPressed: () {
                    if (isEndPage) {
                      context.navigatePush(BlocProvider(
                        create: (context) => LessonCubit(),
                        child: ResultScreen(
                            result: result,
                            sujectId: widget.subjectId,
                            time: time,
                            lessonDetailsResponse: widget.lessonDetailsResponse,
                            countQuiz:
                                widget.lessonDetailsResponse.quizes.length),
                      ));
                    } else {
                      if (idSelected != 0) {
                        countAnswered++;
                        controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.decelerate,
                        );
                        LessonCubit.get(context).currentAnswer(0);
                      } else {
                        showToast(msg: "اختار اجابة".tr(), color: Colors.red);
                      }
                    }
                  })
            ],
          ),
        );
    }
  }
}

class ResultAndQuizesWidget extends StatefulWidget {
  final int result;
  final int quiesz, timer;

  final int countAnswered;

  const ResultAndQuizesWidget(
      {super.key,
      required this.result,
      required this.timer,
      required this.quiesz,
      required this.countAnswered});

  @override
  State<ResultAndQuizesWidget> createState() => _ResultAndQuizesWidgetState();
}

class _ResultAndQuizesWidgetState extends State<ResultAndQuizesWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(widget.quiesz.toString(),
                style: TextStyles.textStyleFontExteraBold22White),
            Text("/", style: TextStyles.textStyleFontExteraBold22White),
            Text(widget.countAnswered.toString(),
                style: TextStyles.textStyleFontExteraBold22White),
          ],
        ),
        Text(
            '${'${(widget.timer / 60).floor()}'.padLeft(2, '0')}:${'${widget.timer % 60}'.padLeft(2, '0')}',
            style: TextStyles.textStyleFontExteraBold22White),
        Row(
          children: [
            Text("النتيجة : ".tr(),
                style: TextStyles.textStyleFontExteraBold22White),
            Text(widget.result.toString(),
                style: TextStyles.textStyleFontExteraBold22White),
          ],
        )
      ],
    );
  }
}
