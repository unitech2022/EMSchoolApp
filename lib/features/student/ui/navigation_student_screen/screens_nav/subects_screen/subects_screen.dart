import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/features/common/models/subject_model.dart';
import 'package:em_school/features/student/bloc/student_cubit/student_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theming/styles.dart';
import '../../../../../../core/utlis/app_model.dart';
import '../../../../../../core/widgets/image_network_widget.dart';
import '../../../../../../core/widgets/percent_widget.dart';

import '../../../subject_details_screen/subject_details_screen.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentCubit, StudentState>(
      builder: (context, state) {
        return Scaffold(

          body: Column(
            children: [
              Text(screensItemsStudent[state.currentNavIndex].name,textAlign: TextAlign.start,style:TextStyles.textStyleFontLight25White ,),
              verticalSpace(15.h),
              Expanded(
                child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 266.w,
                        childAspectRatio: 1.1.w / .8.h,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.w),
                    itemCount: state.homeResponse!.subjects.length,
                    itemBuilder: (ctx, index) {
                      SubjectModel subjectModel = state.homeResponse!.subjects[index];
                      return GestureDetector(
                        onTap: (){
                          context.navigatePush( SubjectDetailsScreen(
                              subjectId:subjectModel.id
                          ));
                        },
                        child: Stack(children: [
                          ImageNetworkWidget(
                            image: subjectModel.image,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 12.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    isArabic()?subjectModel.nameAr:subjectModel.nameEng,
                                    style: TextStyles.textStyleFontBold16White,
                                  ),
                                   PercentWidget(
                                      value:subjectModel.progress ,
                                      textColor: Colors.white,
                                      precentColor: Colors.green)
                                ],
                              ),
                            ),
                          )
                        ]),
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
