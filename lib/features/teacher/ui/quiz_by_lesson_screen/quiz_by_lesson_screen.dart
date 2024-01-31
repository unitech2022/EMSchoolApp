import 'package:em_school/core/enums/loading_status.dart';
import 'package:em_school/core/helpers/spacing.dart';
import 'package:em_school/core/theming/colors.dart';
import 'package:em_school/core/theming/styles.dart';
import 'package:em_school/core/widgets/image_network_widget.dart';
import 'package:em_school/features/common/models/quiz_model.dart';
import 'package:em_school/features/teacher/bloc/teacher_cubit/teacher_cubit.dart';
import 'package:em_school/features/teacher/ui/navigation_teacher_screen/screens_nav/lessons_screen/lessons_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizByLessonScreen extends StatefulWidget {
  final int lessonId;
  const QuizByLessonScreen({super.key, required this.lessonId});

  @override
  State<QuizByLessonScreen> createState() => _QuizByLessonScreenState();
}

class _QuizByLessonScreenState extends State<QuizByLessonScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TeacherCubit.get(context)
        .getQuizesByLessonId(context: context, lessonId: widget.lessonId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherCubit, TeacherState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "الآسئلة",
              style: TextStyles.textStyleFontBold21whit,
            ),
            backgroundColor: Colors.transparent,
          ),
          body: state.getQuizesByLessonState == RequestState.loaded
              ? ListView.separated(
                  itemBuilder: (ctx, index) {
                    QuizModel quizModel = state.quizes[index];
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 5),
                      padding: const EdgeInsets.all(15).w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: ColorsApp.boomSheetColor),
                      child: Row(
                        children: [
                         Container(
                          height: 50.h,
                            width: 50.h,
                            decoration: const BoxDecoration(

                              shape: BoxShape.circle
                            ),
                           child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.r),
                             child: ImageNetworkWidget(image: quizModel.file!=null?quizModel.file!:"", height: 50.h,
                              width: 50.h),
                           ),
                         ) ,
                         horizontalSpace(20.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                quizModel.descAr,
                                style: TextStyles.textStyleFontBold18whit,
                              ),
                             
                              RowEditorWidget(onUpdate: (){}, onDelete: (){})
                            ],
                          ),
                        )
                      ]),
                    );
                  },
                  separatorBuilder: (ctx, index) => const Divider(),
                  itemCount: state.quizes.length)
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
