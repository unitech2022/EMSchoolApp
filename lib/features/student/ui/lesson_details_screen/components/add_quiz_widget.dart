import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/spacing.dart';
import 'package:em_school/core/theming/colors.dart';
import 'package:em_school/core/theming/styles.dart';
import 'package:em_school/features/teacher/ui/add_data_screens/add_quiz_screen/add_quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddQuizWidget extends StatelessWidget {
  final int lessonId;
  const AddQuizWidget({
    super.key,
    required this.lessonId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigatePush(AddQuizScreen(lessonId: lessonId,));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ColorsApp.boomSheetColor,
            borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add,
              color: Colors.white,
            ),
            horizontalSpace(15.w),
            Text(
              "اضافة سؤال",
              style: TextStyles.textStyleFontBold20White,
            )
          ],
        ),
      ),
    );
  }
}
