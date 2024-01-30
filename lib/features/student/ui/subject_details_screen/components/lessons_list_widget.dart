import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/helpers/spacing.dart';
import 'package:em_school/features/teacher/bloc/teacher_cubit/teacher_cubit.dart';
import 'package:em_school/features/teacher/ui/add_data_screens/add_unit_screen/add_unit_screen.dart';
import 'package:em_school/features/teacher/ui/navigation_teacher_screen/screens_nav/lessons_screen/lessons_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../common/models/unit_model.dart';
import 'item_lesson_widget.dart';

class LessonsListWidget extends StatelessWidget {
  final List<UnitResponse> list;
  const LessonsListWidget({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherCubit, TeacherState>(
      builder: (context, state) {
        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (ctx, index) {
              UnitResponse model = list[index];
              return Container(
                margin: EdgeInsets.only(bottom: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      ColorsApp.backgroundColor,
                      ColorsApp.backgroundColor.withOpacity(.5),
                      const Color(0xff29C5EE).withOpacity(.2)
                    ],
                  ),
                ),
                child: ExpansionTile(
                  key: GlobalKey(),
                  trailing: Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xff36545b)),
                      child: const Icon(Icons.add)),
                  childrenPadding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  tilePadding: EdgeInsets.zero,
                  onExpansionChanged: (value) {},
                  collapsedIconColor: Colors.white,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.unitModel.nameAr,
                        style: TextStyles.textStyleFontBold22White,
                      ),
                      horizontalSpace(20.w),
                      RowEditorWidget(
                        onUpdate: () {
                          context.navigatePush(AddUnitScreen(
                            courses: state.homeTeacherResponse!.courses,
                            unitModel:model.unitModel
                          ));
                        },
                        onDelete: () {
                              showDialogDeleteData(
                                context: context,
                                value: model.unitModel.nameAr,
                                onConfiem: () {
                                  pop(context);
                                    TeacherCubit.get(context).deleteUnite(
                                      context: context, unitId: model.unitModel.id);
                                  
                                });
                         
                        },
                      )
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r)),
                  children: [ItemLessonWidget(lessons: model.lessons)],
                ),
              );
            });
      },
    );
  }
}
