import 'package:em_school/core/enums/loading_status.dart';
import 'package:em_school/core/helpers/spacing.dart';
import 'package:em_school/features/common/models/course_model.dart';
import 'package:em_school/features/student/bloc/subject_cubit/subject_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/styles.dart';
import 'components/app_bar_and_image_widget.dart';
import 'components/lessons_list_widget.dart';

class SubjectDetailsScreen extends StatefulWidget {
  final int subjectId;

  const SubjectDetailsScreen({super.key, required this.subjectId});

  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SubjectCubit.get(context)
        .getSubjectDetails(context: context, subjectId: widget.subjectId);
  }

  bool expanded = false;
  CourseModel? currentCourse;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectCubit, SubjectState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            elevation: 0,
            centerTitle: true,
            // title: Text(
            //   s,
            //   style: TextStyles.textStyleFontBold21whit,
            // ),
            backgroundColor: Colors.transparent,
          ),
          body: state.getSubjectDetailsState == RequestState.loaded
              ? CustomScrollView(
                  slivers: [
                    AppBarAndImageWidget(
                        subjectModel: state.subjectDetailsResponse!.subject),
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: Column(
                        children: [
                          /// courses
                          ExpansionTile(
                            key: GlobalKey(),
                            childrenPadding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            tilePadding: EdgeInsets.zero,
                            initiallyExpanded: expanded,
                            onExpansionChanged: (value) {
                              expanded = value;
                            },
                            collapsedBackgroundColor: Colors.transparent,
                            collapsedIconColor: Colors.white,
                            title:state
                                .subjectDetailsResponse!.courses.isEmpty?const SizedBox(): Text(
                              currentCourse == null
                                  ? state
                                      .subjectDetailsResponse!.courses[0].nameAr
                                  : currentCourse!.nameAr,
                              style: TextStyles.textStyleFontBold22White,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r)),
                            children: state.subjectDetailsResponse!.courses
                                .map((e) => ListTile(
                                      visualDensity: const VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      minVerticalPadding: 0.0,
                                      onTap: () {
                                        setState(() {
                                          expanded = !expanded;
                                          currentCourse = e;
                                          SubjectCubit.get(context)
                                              .getUnitDetails(
                                                  context: context,
                                                  courseId: e.id);
                                        });
                                      },
                                      title: Text(
                                        e.nameAr,
                                        style: TextStyles
                                            .textStyleFontMeduim20White,
                                      ),
                                      trailing: Icon(
                                        Icons.check,
                                        color: currentCourse == null ||
                                                currentCourse!.id != e.id
                                            ? Colors.transparent
                                            : Colors.green,
                                      ),
                                    ))
                                .toList(),
                          ),
                          verticalSpace(20.h),
                           LessonsListWidget(list:  SubjectCubit.get(context).unitResponses!,)
                        ],
                      ),
                    ))
                  ],
                )
              : const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(

                    ),
                  ),
                ),
        );
      },
    );
  }
}


