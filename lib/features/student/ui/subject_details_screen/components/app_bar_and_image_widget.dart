import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/image_network_widget.dart';
import '../../../../../core/widgets/percent_widget.dart';
import '../../../../common/models/subject_model.dart';

class AppBarAndImageWidget extends StatelessWidget {
  final SubjectModel subjectModel;

  const AppBarAndImageWidget({super.key, required this.subjectModel});


  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      expandedHeight: context.height / 3,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(26.h),
        child: Container(
          margin: EdgeInsets.only(
              bottom: 20.h, left: 20.w, right: 20.w),
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                subjectModel.nameAr,
                style: TextStyles.textStyleFontBold22White,
              ),
               PercentWidget(
                  value: subjectModel.progress,
                  size: 20,
                  strok: 5,
                  textColor: Colors.white,
                  precentColor: Colors.green)
            ],
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: ImageNetworkWidget(
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
          image: subjectModel.image,
        ),
      ),
    );
  }
}