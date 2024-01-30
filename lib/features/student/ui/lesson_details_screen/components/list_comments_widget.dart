import 'package:easy_localization/easy_localization.dart';
import 'package:em_school/core/enums/loading_status.dart';
import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/layout/app_fonts.dart';
import 'package:em_school/core/widgets/circular_progress.dart';
import 'package:em_school/core/widgets/custom_button.dart';
import 'package:em_school/features/student/bloc/lesson_cubit/lesson_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/image_network_widget.dart';
import '../../../../common/models/comment_model.dart';
import '../../../../common/models/lesson_model.dart';

class ListCommentsWidget extends StatefulWidget {
  final LessonDetailsResponse response;
  const ListCommentsWidget({super.key, required this.response});

  @override
  State<ListCommentsWidget> createState() => _ListCommentsWidgetState();
}

class _ListCommentsWidgetState extends State<ListCommentsWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.response.comments.length,
      itemBuilder: (ctx, index) {
        CommentResponse comment = widget.response.comments[index];

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
          padding: const EdgeInsets.all(15).w,
          margin: EdgeInsets.only(bottom: 12.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    height: 50.h,
                    width: 50.h,
                    child: ImageNetworkWidget(
                      height: 50.h,
                      width: 50.h,
                      errorWidget: Image.asset("assets/images/e.png",
                          height: 50.h, width: 50.h, fit: BoxFit.contain),
                      image: comment.userDetail.profileImage ?? "",
                      fit: BoxFit.contain,
                    ),
                  ),
                  horizontalSpace(10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.userDetail.fullName,
                          style: TextStyles.textStyleFontBold18whit,
                        ),
                        verticalSpace(10.h),
                        Text(
                          comment.comment.text,
                          maxLines: 2,
                          style: TextStyles.textStyleFontBold15grey,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        comment.comment.createAte.split("T")[0],
                        style: TextStyles.textStyleFontNormal12grey,
                      ),
                      verticalSpace(10.h),

                      // add reply
                      GestureDetector(
                        onTap: () {
                          addReplay(
                            context,
                            commentId: comment.comment.id,
                            lessonId: comment.comment.lessonId,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: ColorsApp.mainColor),
                          child: Text(
                            "اضافة رد".tr(),
                            style: TextStyles.textStyleFontMeduim14White,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              widget.response.replies
                      .where((element) =>
                          element.reply.commentId == comment.comment.id)
                      .isNotEmpty
                  ? SizedBox(
                      width: double.infinity,
                      child: ExpansionTile(
                        collapsedIconColor: ColorsApp.mainColor,
                        iconColor: ColorsApp.mainColor,

                        title: Row(
                          children: [
                            Text(
                              getTitleReplay(widget.response.replies
                                  .where((element) =>
                                      element.reply.commentId ==
                                      comment.comment.id)
                                  .length),
                              style: TextStyles.textStyleFontBold14Blue,
                            ),
                          ],
                        ),
                        // REPLIES
                        children: widget.response.replies
                            .where((element) =>
                                element.reply.commentId == comment.comment.id)
                            .map((e) => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.w, vertical: 15.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle),
                                        height: 25.h,
                                        width: 25.h,
                                        child: ImageNetworkWidget(
                                          height: 25.h,
                                          width: 25.h,
                                          errorWidget: Image.asset(
                                              "assets/images/e.png",
                                              height: 25.h,
                                              width: 25.h,
                                              fit: BoxFit.contain),
                                          image:
                                              e.userDetail.profileImage ?? "",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      horizontalSpace(6.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.userDetail.fullName,
                                              style: TextStyles
                                                  .textStyleFontBold12whit,
                                            ),
                                            verticalSpace(5.h),
                                            Text(
                                              e.reply.text,
                                              maxLines: 2,
                                              style: TextStyles
                                                  .textStyleFontBold11grey,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        e.reply.createAte.split("T")[0],
                                        style: TextStyles
                                            .textStyleFontNormal10grey,
                                      )
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.grey,
        height: .2,
      ),
    );
  }

  String getTitleReplay(int count) {
    switch (count) {
      case 1:
        return "رد واحد";
      case 2:
        return "ردان";
      default:
        return "$count ردود ";
    }
  }

  // add reply
  void addReplay(BuildContext context, {commentId, lessonId}) {
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
                  "اضافة رد".tr(),
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
                      hintText: "اكتب ردك".tr(),
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
                                  LessonCubit.get(context).addReply(
                                      context: context,
                                      lessonId: lessonId,
                                      commentId: commentId,
                                      text: controller.text);

                                  controller.clear();
                                  // showToast(
                                  //     msg: "تم ارسال hgnv".tr(),
                                  //     color: Colors.red);
                                  pop(context);
                                } else {
                                  showToast(msg: "", color: Colors.red);
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
}
