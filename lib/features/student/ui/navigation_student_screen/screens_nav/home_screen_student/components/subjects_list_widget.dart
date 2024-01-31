import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/theming/styles.dart';
import '../../../../../../../core/widgets/image_network_widget.dart';
import '../../../../../../../core/widgets/percent_widget.dart';
import '../../../../../../common/models/subject_model.dart';

import '../../../../subject_details_screen/subject_details_screen.dart';

class SubjectsListWidget extends StatelessWidget {
  final List<SubjectModel> subjects;

  const SubjectsListWidget({super.key, required this.subjects});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
       childAspectRatio: .93.w,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
        children:subjects.map((e) =>
            GestureDetector(
              onTap: (){
                context.navigatePush( SubjectDetailsScreen(
                  subjectId:e.id
                ));
              },
              child: Stack(children: [
                ImageNetworkWidget(
                  image: e.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          isArabic()?e.nameAr:e.nameEng,
                          style: TextStyles.textStyleFontBold14White,
                        ),
                         PercentWidget(
                            value:  e.progress ,
                            size: 15.w,strok: 3.5.w,
                            textColor: Colors.white,
                            precentColor: Colors.green)
                      ],
                    ),
                  ),
                )
              ]),
            )).toList(),
      ),
    );
  }
}
