import 'package:easy_localization/easy_localization.dart';
import 'package:em_school/core/data_static/data_for_login.dart';
import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/spacing.dart';
import 'package:em_school/core/layout/app_fonts.dart';
import 'package:em_school/core/theming/colors.dart';
import 'package:em_school/core/utlis/app_model.dart';

import 'package:em_school/features/common/auth/ui/screens/register_screen/widgets/field_selector_register_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/app_regex.dart';
import '../../../../../../core/helpers/helper_functions.dart';
import '../../../../../../core/theming/styles.dart';
import '../../../../../../core/widgets/app_text_button.dart';
import '../../../../../../core/widgets/text_field_widget.dart';
import '../../../../../../core/widgets/texts.dart';
import '../../../../models/register_body_reqquest.dart';
import '../../../cubit/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  final String role, phone, code;

  const RegisterScreen(
      {super.key, required this.role, required this.phone, required this.code});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      // SizedBox(height: .h),

                      Text("انشاء حساب جديد".tr(),
                          style: TextStyles.textStyleFontExtraBold27),
                      Text("الرجاء ادخال البيانات الخاصة بك".tr(),
                          style: TextStyles.textStyleFontMedium27grey),
                      verticalSpace(40.h),
                      TextFormFieldWidget(
                        controller: AuthCubit.get(context).nameController,
                        hintText: "الاسم".tr(),
                        validator: (value) {},
                        isObscureText: false,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 30.h),
                      ),
                      verticalSpace(10.h),

                      ///  نوع  التعليم
                      FieldSelectorRegisterWidget(
                        borderColor:AuthCubit.get(context).typeEducationModel!=null? Colors.blue: const Color(0xFFB2B5B9),
                        onTap: () {
                          showBottomSelector(
                              list: responseDataForLogin!.typeEducations,
                              type: 0,
                              contextBloc: context);
                        },
                        value:
                            AuthCubit.get(context).typeEducationModel == null
                                ? "نوع التعليم".tr()
                                : AuthCubit.get(context)
                                    .typeEducationModel!
                                    .nameAr,
                        label: "نوع التعليم".tr(),
                      ),
                      verticalSpace(10.h),

                      ///    المرحلة التغليمية
                      FieldSelectorRegisterWidget(
                        borderColor: AuthCubit.get(context).stageModel!=null? Colors.blue: const Color(0xFFB2B5B9),
                        onTap: () {
                          showBottomSelector(
                              list:
                                  AuthCubit.get(context).typeEducationModel ==
                                          null
                                      ? []
                                      : responseDataForLogin!.stages
                                          .where((element) =>
                                              element.typeEducationId ==
                                              AuthCubit.get(context)
                                                  .typeEducationModel!
                                                  .id)
                                          .toList(),
                              type: 1,
                              contextBloc: context);
                        },
                        value: AuthCubit.get(context).stageModel == null
                            ? "المرحلة التعليمية".tr()
                            : AuthCubit.get(context).stageModel!.nameAr,
                        label: "المرحلة التعليمية".tr(),
                      ),
                      verticalSpace(10.h),

                      ///  الصف الدراسي

                      widget.role==AppModel.studentRole?    FieldSelectorRegisterWidget(
                        borderColor: AuthCubit.get(context).classRoomModel!=null? Colors.blue: const Color(0xFFB2B5B9),
                        onTap: () {
                          showBottomSelector(
                              contextBloc: context,
                              list: AuthCubit.get(context).stageModel == null
                                  ? []
                                  : responseDataForLogin!.classRooms
                                  .where((element) =>
                              element.stageId ==
                                  AuthCubit.get(context)
                                      .stageModel!
                                      .id)
                                  .toList(),
                              type: 2);
                        },
                        value: AuthCubit.get(context).classRoomModel == null
                            ? "الصف الدراسي".tr()
                            : AuthCubit.get(context).classRoomModel!.nameAr,
                        label: "الصف الدراسي".tr(),
                      ):

                          /// التخصص
                      FieldSelectorRegisterWidget(
                        borderColor: AuthCubit.get(context).stageModel!=null? Colors.blue: const Color(0xFFB2B5B9),
                        onTap: () {
                          showBottomSelector(
                              contextBloc: context,
                              list: AuthCubit.get(context).stageModel == null
                                  ? []
                                  : responseDataForLogin!.subjects
                                  .where((element) =>
                              element.stageId ==
                                  AuthCubit.get(context)
                                      .stageModel!
                                      .id)
                                  .toList(),
                              type: 3);
                        },
                        value: AuthCubit.get(context).subjectModel == null
                            ? "التخصص".tr()
                            : AuthCubit.get(context).subjectModel!.nameAr,
                        label: "التخصص".tr(),
                      )
                      ,
                      verticalSpace(25.h),

                      /// password
                      TextFormFieldWidget(
                        controller: AuthCubit.get(context).passwordController,
                        hintText: "كلمة السر".tr(),
                        validator: (value) {},
                        isObscureText: false,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 30.h),
                      ),
                      verticalSpace(60.h),

                      /// button register
                      AppTextButton(
                        buttonText: "انشاء".tr(),
                        textStyle: TextStyles.textStyleFontExtraBold24White,
                        onPressed: () {
                          if (isValidate(context: context)) {
                            RequestBodyRegister requestBodyRegister =  RequestBodyRegister(
                              subjectId: widget.role==AppModel.studentRole?0:AuthCubit.get(context).subjectModel!.id,
                              fullName: AuthCubit.get(context).nameController.text,
                              typeEducationId: AuthCubit.get(context)
                                .typeEducationModel!
                                .id,
                              stageId: AuthCubit.get(context)
                                .stageModel!
                                .id,
                              classRoomId: widget.role==AppModel.studentRole? AuthCubit.get(context)
                                .classRoomModel!
                                .id:0,
                              userName: widget.phone,
                              password: AuthCubit.get(context)
                                .passwordController
                                .text,
                              code:widget.code,
                              role: widget.role,
                            );
                            AuthCubit.get(context).registerUser(
                              requestBodyRegister,
                              context: context,
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            )));
      },
    );
  }

  void showBottomSelector({list, type, contextBloc}) {
    showBottomSheetWidget(
        context,
        Container(
          padding:
              const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 20),
          decoration: const BoxDecoration(
              color: ColorsApp.boomSheetColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          height: context.height / 2,
          width: double.infinity,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (ctx, index) {
                      dynamic model = list[index];
                      return GestureDetector(
                        onTap: () {
                          AuthCubit.get(contextBloc)
                              .changeCurrentDataLogin(model: model, type: type);
                          pop(context);
                        },
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(),
                          child: Row(
                            children: [
                              Texts(
                                  title: model.nameAr,
                                  textColor: Colors.white,
                                  family: AppFonts.innerMedium,
                                  size: 20.sp),
                            ],
                          ),
                        ),
                      );
                    }))
          ]),
        ));
  }

  bool isValidate({context}) {
    if (AuthCubit.get(context).nameController.text.isEmpty ||
        AuthCubit.get(context).nameController.text == "") {
      showToast(msg: "اكتب الاسم".tr(), color: Colors.red);
      return false;
    } else if (AuthCubit.get(context).typeEducationModel == null) {
      showToast(msg: "اختار نوع التعليم".tr(), color: Colors.red);
      return false;
    } else if (AuthCubit.get(context).stageModel == null) {
      showToast(msg: "اختار المرحلة التعليمية".tr(), color: Colors.red);
      return false;
    } else if (widget.role==AppModel.studentRole&&AuthCubit.get(context).classRoomModel == null) {
      showToast(msg: "اختار الصف الدراسي".tr(), color: Colors.red);
      return false;
    }else if (widget.role==AppModel.teacherRole&&AuthCubit.get(context).subjectModel == null) {
      showToast(msg: "اختار التخصص".tr(), color: Colors.red);
      return false;
    } else if (AuthCubit.get(context).passwordController.text.isEmpty ||
        !(AppRegex.isPasswordValid(
            AuthCubit.get(context).passwordController.text))) {
      showToast(
          msg: "يجب ان يكون ٨ احرف و يحتوي علي احزف كبيرة و رموز".tr(), color: Colors.red);
      return false;
    } else {
      return true;
    }
  }
}
