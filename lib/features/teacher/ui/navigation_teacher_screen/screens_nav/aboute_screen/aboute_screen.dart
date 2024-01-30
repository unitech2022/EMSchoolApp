import 'package:easy_localization/easy_localization.dart';
import 'package:em_school/core/helpers/spacing.dart';
import 'package:em_school/core/theming/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AbouteScreen extends StatelessWidget {
  const AbouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          children: [
            verticalSpace(20.h),
               Row(
                 children: [
                   Text(
                      "عن التطبيق".tr(),
                      style: TextStyles.textStyleFontBold22White,
                    ),
                 ],
               ),
            verticalSpace(20.h),

            SingleChildScrollView(
              child: Text(
                "هو تطبيق يتيح الدراسة بأحدث التقنيات والأساليب الممتعة بأي وقت وأي مكانهو تطبيق يتيح الدراسة بأحدث التقنيات والأساليب الممتعة بأي وقت وأي مكانهو تطبيق يتيح الدراسة بأحدث التقنيات والأساليب الممتعة بأي وقت وأي مكانهو تطبيق يتيح الدراسة بأحدث التقنيات والأساليب الممتعة بأي وقت وأي مكانهو تطبيق يتيح الدراسة بأحدث التقنيات والأساليب الممتعة بأي وقت وأي مكانهو تطبيق يتيح الدراسة بأحدث التقنيات والأساليب الممتعة بأي وقت وأي مكان"
               , style: TextStyles.textStyleFontBold20White.copyWith(height: 1.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
