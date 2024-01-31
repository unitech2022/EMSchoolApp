import 'package:easy_localization/easy_localization.dart';
import 'package:em_school/core/enums/loading_status.dart';
import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/helpers/spacing.dart';
import 'package:em_school/core/theming/styles.dart';
import 'package:em_school/core/utlis/app_model.dart';
import 'package:em_school/core/widgets/rating_bar_widget.dart';
import 'package:em_school/features/student/bloc/lesson_cubit/lesson_cubit.dart';
import 'package:em_school/features/student/ui/lesson_details_screen/components/add_quiz_widget.dart';
import 'package:em_school/features/student/ui/quiz_screen/quiz_screen.dart';
import 'package:em_school/features/teacher/ui/quiz_by_lesson_screen/quiz_by_lesson_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/custom_button.dart';
import 'components/add_comments_rats_widget.dart';
import 'components/list_comments_widget.dart';
import 'components/you_tube_player_widget.dart';

class LessonDetailsScreen extends StatefulWidget {
  final int lessonId;

  const LessonDetailsScreen({super.key, required this.lessonId});

  @override
  State<LessonDetailsScreen> createState() => _LessonDetailsScreenState();
}

class _LessonDetailsScreenState extends State<LessonDetailsScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    LessonCubit.get(context)
        .getLessonDetails(context: context, lessonId: widget.lessonId)
        .then((value) {
      _controller = LessonCubit.get(context).controller;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    // LessonCubit.get(context).timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonCubit, LessonState>(
      builder: (context, state) {
        return state.getLessonDetailsState == RequestState.loaded
            ? Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        /// video
                        YouTubePlayerWidget(
                            controller: _controller,
                            onEnded: (meta) {
                              _controller.seekTo(Duration.zero);
                              _controller.pause();
                            }),

                        // likes and  viewas
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      state.isLike
                                          ? FontAwesomeIcons.solidThumbsUp
                                          : FontAwesomeIcons.thumbsUp,
                                      color: ColorsApp.mainColor,
                                    ),
                                    onPressed: () async {
                                      await LessonCubit.get(context)
                                          .addLikeLesson(
                                              context: context,
                                              lessonId: state
                                                  .lessonDetailsResponse!
                                                  .lesson
                                                  .id);
                                    },
                                  ),
                                  horizontalSpace(5.w),
                                  Text(
                                    LessonCubit.get(context).likes.toString(),
                                    style: TextStyles.textStyleFontBold15whit,
                                  )
                                ],
                              ),
                              // rating

                              RatingBarWidget(
                                rate: state.lessonDetailsResponse!.lesson.rate,
                                size: 25.w,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset("assets/icons/Eye.svg"),
                                  horizontalSpace(15.w),
                                  Text(
                                    state.lessonDetailsResponse!.lesson.views
                                        .toString(),
                                    style: TextStyles.textStyleFontBold15whit,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            children: [
                              ///add comments and save and rate
                              currentUser!.user.role == AppModel.teacherRole
                                  ?
                                  // add quiz
                                  AddQuizWidget(
                                      lessonId: state
                                          .lessonDetailsResponse!.lesson.id,
                                    )
                                  : AddCommentsRatsWidget(
                                      lessonModel:
                                          state.lessonDetailsResponse!.lesson,
                                    ),
                              verticalSpace(25.h),
                              Row(
                                children: [
                                  Text(
                                    isArabic()?state.lessonDetailsResponse!.lesson.nameAr:
                                    state.lessonDetailsResponse!.lesson.nameEng,
                                    style: TextStyles.textStyleFontBold21whit,
                                  ),
                                ],
                              ),
                              Text(
                                isArabic()?
                                state.lessonDetailsResponse!.lesson.descAr:
                                state.lessonDetailsResponse!.lesson.descEng
                                ,
                                style: TextStyles.textStyleFontMeduim21grey,
                              ),
                              verticalSpace(15.h),
                              Container(
                                color: ColorsApp.backgroundColor,
                                padding: const EdgeInsets.all(30).w,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        title: currentUser!.user.role ==
                                                AppModel.studentRole
                                            ? "الذهاب الي الاختبار".tr()
                                            : "قائمة الاسئلة".tr(),
                                        onPressed: () {
                                          if (currentUser!.user.role ==
                                              AppModel.studentRole) {
                                            context.navigatePush(BlocProvider(
                                              create: (context) =>
                                                  LessonCubit(),
                                              child: QuizScreen(
                                                  lessonDetailsResponse: state
                                                      .lessonDetailsResponse!),
                                            ));
                                          } else {
                                            //todo : page quizez
                                            context.navigatePush(
                                                QuizByLessonScreen(lessonId:state
                                                      .lessonDetailsResponse!.lesson.id));
                                          }
                                        },
                                        backgroundColor: Colors.green,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              verticalSpace(25.h)

                              /// comments and replies list
                              ,
                              Row(
                                children: [
                                  Text(
                                    "التعليقات".tr(),
                                    style: TextStyles.textStyleFontBold21whit,
                                  ),
                                  verticalSpace(20.h),
                                ],
                              ),

                              verticalSpace(15.h),
                              ListCommentsWidget(
                                response: state.lessonDetailsResponse!,
                              ),

                              verticalSpace(30.h),

                              verticalSpace(100.h)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }
}
