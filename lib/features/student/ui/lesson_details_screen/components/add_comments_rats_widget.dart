import 'package:easy_localization/easy_localization.dart';
import 'package:em_school/core/enums/loading_status.dart';
import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/widgets/circular_progress.dart';
import 'package:em_school/features/common/models/lesson_model.dart';
import 'package:em_school/features/student/bloc/favoraite_cubit/favoraite_cubit.dart';
import 'package:em_school/features/student/bloc/lesson_cubit/lesson_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/layout/app_fonts.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/utlis/app_model.dart';
import '../../../../../core/widgets/custom_button.dart';

class AddCommentsRatsWidget extends StatefulWidget {
  final LessonModel lessonModel;

  const AddCommentsRatsWidget({super.key, required this.lessonModel});

  @override
  State<AddCommentsRatsWidget> createState() => _AddCommentsRatsWidgetState();
}

class _AddCommentsRatsWidgetState extends State<AddCommentsRatsWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(favFound.length);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ContainerCommentAndRate(
          title: "اسآل".tr(),
          icon: Icons.mode_comment_outlined,
          onTap: () {
            addComent(context);
          },
        ),
        ContainerCommentAndRate(
          title: "قيم".tr(),
          icon: Icons.star_border,
          onTap: () {
            //
            rateLesson(context, widget.lessonModel.id);
          },
        ),
        BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            return ContainerCommentAndRate(
              title: "حفظ".tr(),
              icon: favFound.containsKey(widget.lessonModel.id)
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              onTap: () {
                FavoriteCubit.get(context)
                    .addFav(widget.lessonModel.id, context: context);
              },
            );
          },
        ),
      ],
    );
  }

  void addComent(BuildContext context) {
    return showBottomSheetWidget(context, BlocBuilder<LessonCubit, LessonState>(
      builder: (contextBloc, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(contextBloc).viewInsets.bottom),
            child: Container(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 20.w,
                right: 20.w,
              ),
              decoration: const BoxDecoration(
                  color: ColorsApp.boomSheetColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              width: double.infinity,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          context.navigatePop();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                  ],
                ),
                Text(
                  "اضافة سؤال".tr(),
                  style: TextStyles.textStyleFontBold21whit,
                ),
                verticalSpace(20.h),
                Container(
                  padding: EdgeInsets.only(
                      right: 10.w, left: 10.w, top: 10.h, bottom: 10.h),
                  decoration: BoxDecoration(
                    color: ColorsApp.boomSheetColor,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(width: .5, color: Colors.grey),
                  ),
                  child: TextField(
                    controller: controller,
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "اكتب سؤالك".tr(),
                      border: InputBorder.none,
                      hintStyle: const TextStyle(
                          fontFamily: AppFonts.innerMedium,
                          color: Colors.white),
                    ),
                  ),
                ),
                verticalSpace(30.h),
                state.addCommentState == RequestState.loading
                    ? const CustomCircularProgress(
                        color: Colors.green,
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              title: "ارسال".tr(),
                              onPressed: () {
                                if (controller.text.isNotEmpty) {
                                  LessonCubit.get(context).addComment(
                                      context: context,
                                      lessonId: widget.lessonModel.id,
                                      comment: controller.text);

                                  controller.clear();
                                  showToast(
                                      msg: "تم ارسال السؤال".tr(),
                                      color: Colors.red);
                                  pop(context);
                                } else {
                                  showToast(
                                      msg: "لا يمكن ارسال سؤال فارغ".tr(),
                                      color: Colors.red);
                                }
                              },
                              backgroundColor: Colors.green,
                            ),
                          )
                        ],
                      ),
                verticalSpace(30.h),
              ]),
            ),
          ),
        );
      },
    ));
  }

  Future<dynamic> rateLesson(BuildContext contextBloc, lessonId) {
    double stars = 3;
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return BlocBuilder<LessonCubit, LessonState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  width: double.infinity,
                  // height: heightScreen(context) / 1.5,
                  padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 30.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.r),
                        topRight: Radius.circular(15.r)),
                    color: ColorsApp.boomSheetColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                  sizedHeight(15.h),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                pop(context);
                              },
                              icon:
                                  const Icon(Icons.close, color: Colors.white))
                        ],
                      ),

                      Text(
                        "اترك تقييما".tr(),
                        style: TextStyles.textStyleFontBold20White,
                      ),

                      sizedHeight(30.h),
                      SizedBox(
                        child: RatingBar.builder(
                          initialRating: stars,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0.w),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          onRatingUpdate: (rating) {
                            stars = rating;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      state.addRateState == RequestState.loading
                          ? const CustomCircularProgress(
                              strokeWidth: 4,
                            )
                          : CustomButton(
                              onPressed: ()async {
                                print(stars);
                              await  LessonCubit.get(contextBloc)
                                    .addRateLesson(
                                        context: contextBloc,
                                        comment: "", 
                                        lessonId: lessonId,
                                        stare: stars.toInt())
                                    .then((value) {
                                  pop(context);
                                });
                              },
                              title: "ارسال".tr(),
                            ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ContainerCommentAndRate extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function() onTap;

  const ContainerCommentAndRate(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
            color: ColorsApp.boomSheetColor,
            borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            horizontalSpace(5.w),
            Text(
              title.tr(),
              style: TextStyles.textStyleFontBold18whit,
            )
          ],
        ),
      ),
    );
  }
}
