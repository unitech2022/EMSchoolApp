import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/spacing.dart';
import 'package:em_school/core/theming/colors.dart';
import 'package:em_school/core/theming/styles.dart';
import 'package:em_school/core/widgets/custom_button.dart';
import 'package:em_school/features/common/models/lesson_model.dart';
import 'package:em_school/features/student/bloc/lesson_cubit/lesson_cubit.dart';
import 'package:em_school/features/student/ui/quiz_screen/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultScreen extends StatefulWidget {
  final int result;
  final int countQuiz ,time;
  final int? sujectId;
  final LessonDetailsResponse lessonDetailsResponse;

  const ResultScreen(
      {super.key,
      required this.result,    required this.time,
      required this.countQuiz,
      required this.lessonDetailsResponse,
      this.sujectId});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if ((widget.result / widget.countQuiz * 100) >= 50) {
      LessonCubit.get(context).playSound(file: "sounds/winner.mp3");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonCubit, LessonState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xff68019E),
          extendBody: true,
          bottomSheet: Container(
            color: const Color(0xff68019E),
            child: Container(
              height: context.height / 4,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorsApp.boomSheetColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.r),
                      topRight: Radius.circular(25.r))),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      radius: BorderRadius.circular(30.r),
                      title: "اعد الاختبار",
                      fontSize: 22.sp,
                      height: 63.h,
                      onPressed: () {
                        context.navigatePush(BlocProvider(
                          create: (context) => LessonCubit(),
                          child: QuizScreen(
                              lessonDetailsResponse:
                                  widget.lessonDetailsResponse),
                        ));
                      },
                      backgroundColor: ColorsApp.boomSheetColor,
                      borderSide:
                          BorderSide(color: ColorsApp.mainColor, width: 5.w),
                    ),
                  ),
                  horizontalSpace(20.w),
                  Expanded(
                    child: CustomButton(
                      radius: BorderRadius.circular(30.r),
                      title: "إنهاء",
                      fontSize: 22.sp,
                      height: 63.h,
                      onPressed: () {
                        //todo : add


                          LessonCubit.get(context).addExerciseCompleted(
                              result: widget.result,
                              lessonId: widget.lessonDetailsResponse.lesson.id,
                              context: context,
                              finalDegree:  widget.countQuiz,
                              subjectId: widget
                                  .lessonDetailsResponse.lesson.subjectId);
                        // } else {
                        //   context.navigatePush(BlocProvider(
                        //     create: (context) => StudentCubit(),
                        //     child: NavigationStudentScreen(),
                        //   ));
                        // }
                      },
                      backgroundColor: ColorsApp.blueColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(30.h),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0).w,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset((widget.result / widget.countQuiz * 100) >= 50?"assets/images/cup.png":"assets/images/faild.png "),


                        ],
                      ),
                      verticalSpace(20.h),

                      /// results
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.result.toString(),
                              style: TextStyles.textStyleFontExteraBold47White),
                          Text(
                            " / ",
                            style: TextStyles.textStyleFontExteraBold47White
                                .copyWith(color: Colors.white.withOpacity(.5)),
                          ),
                          Text(
                            widget.countQuiz.toString(),
                            style: TextStyles.textStyleFontExteraBold47White
                                .copyWith(color: Colors.white.withOpacity(.5)),
                          ),
                        ],
                      )

                      /// recent and time
                      ,
                      verticalSpace(50.h),
                      Row(
                        children: [
                          ContainerResultsWidget(
                            value:
                                "${(widget.result / widget.countQuiz * 100).toStringAsFixed(0)} %",
                          ),
                          horizontalSpace(25.w),
                           ContainerResultsWidget(
                            value: '${'${(widget.time/60).floor()}'.padLeft(2, '0')}:${'${widget.time%60}'.padLeft(2, '0')}',
                          )
                        ],
                      ),
                      verticalSpace(20.h),
                    ],
                  ),
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ContainerResultsWidget extends StatelessWidget {
  final String value;

  const ContainerResultsWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 78.h,
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          color: const Color(0xff7A1FAA)),
      child: Text(
        value,
        style: TextStyles.textStyleFontSemiBold23White,
      ),
    ));
  }
}
