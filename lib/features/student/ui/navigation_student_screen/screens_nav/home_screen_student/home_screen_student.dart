import 'package:easy_localization/easy_localization.dart';
import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/spacing.dart';
import 'package:em_school/features/common/models/entertainment_model.dart';
import 'package:em_school/features/student/bloc/student_cubit/student_cubit.dart';
import 'package:em_school/features/student/ui/open_pdf_link_screen/open_pdf_link_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theming/styles.dart';
import '../../../../../../core/utlis/app_model.dart';
import '../../../../../../core/widgets/image_network_widget.dart';
import 'components/carousel_widget.dart';
import 'components/subjects_list_widget.dart';

class HomeScreenStudent extends StatelessWidget {
  const HomeScreenStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentCubit, StudentState>(
      builder: (context, state) {
        return Scaffold(

          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    screensItemsStudent[state.currentNavIndex]
                    .name,textAlign: TextAlign.start,style:TextStyles.textStyleFontLight25White ,),
                  verticalSpace(15.h),
                   TextTitle(title: "استكشف".tr(),),
                  verticalSpace(10.h),
                  /// SUBJECTS
                  SubjectsListWidget(subjects:state.homeResponse!.subjects)
                  ,verticalSpace(24.h),
                   TextTitle(title: "الفعاليات".tr(),),
                  verticalSpace(15.h),
                  /// sliders
                  CarouselWidget(bunners: state.homeResponse!.bunners,),
                verticalSpace(24.h),
             TextTitle(title: "الترفيه".tr(),),
            verticalSpace(15.h),
                  Container(
                    height: 120.h,
                  alignment: Alignment.center,
                    child: ListView.builder(

                        itemCount: state.homeResponse!.entertainments.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx,index){
                          EntertainmentModel model=state.homeResponse!.entertainments[index];
                      return
                          GestureDetector(
                            onTap: (){
                              context.navigatePush(OpenPdfFileScreen(model: model,));
                            },
                            child: Container(
                              height: 120.h,
                              width:85.w,
                              margin: EdgeInsets.symmetric(horizontal: 10.w),
                              child: ImageNetworkWidget(
                                height: 120.h,
                                width:85.w,
                                image: model.image,
                              ),
                            ),
                          );
                    }),
                  ),
                  verticalSpace(100.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TextTitle extends StatelessWidget {
  final String title;

  const TextTitle({super.key, required this.title});


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title.tr(),textAlign: TextAlign.start,style:TextStyles.textStyleFontLight21White ,),
      ],
    );
  }
}

