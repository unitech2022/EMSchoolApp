import 'package:easy_localization/easy_localization.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/theming/colors.dart';
import 'package:em_school/core/theming/styles.dart';
import 'package:em_school/core/widgets/app_text_button.dart';
import 'package:em_school/features/common/auth/cubit/auth_cubit.dart';
import 'package:em_school/features/common/auth/ui/screens/login_with_password_screen/login_with_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:ui' as ui;

class OTPScreen extends StatefulWidget {
  final int status;

  /// register = 0 / login = 1
  final String role, phone, codeSend;

  const OTPScreen(
      {super.key,
      required this.status,
      required this.role,
      required this.phone,
      required this.codeSend});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String code = "";

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
                child: Column(
                  children: [
                    SizedBox(height: 208.h),
                    Text("آدخل الكود المرسل الي رقمك".tr(),
                        style: TextStyles.textStyleFontExtraBold27),
                    SizedBox(height: 40.h),
                    Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: SizedBox(
                        width: 250.w,
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                          ),
                          length: 4,
                          obscureText: false,
                          obscuringCharacter: '*',
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          blinkWhenObscuring: true,
                          boxShadows: const [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 3,
                              spreadRadius: 3,
                              color: Color.fromARGB(25, 0, 0, 0),
                            ),
                          ],
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                              fieldOuterPadding: const EdgeInsets.only(left: 5),
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10),
                              fieldHeight: 65.h,
                              fieldWidth: 55.w,
                              borderWidth: 3,
                              activeColor: ColorsApp.mainColor,
                              inactiveColor: Colors.white,
                              inactiveFillColor: Colors.transparent,
                              selectedFillColor: Colors.transparent,
                              activeFillColor: Colors.transparent,
                              selectedColor: Colors.white),
                          cursorColor: Colors.white,
                          animationDuration: const Duration(milliseconds: 300),
                          backgroundColor: Colors.transparent,
                          enableActiveFill: true,
                          keyboardType: TextInputType.number,
                          onCompleted: (v) {
                            code = v;
                          },
                          onChanged: (value) {},
                          beforeTextPaste: (text) {
                            return true;
                          },
                        ),
                      ),
                    ),

                  widget.status==1?
                      Column(
                        children: [
                          SizedBox(height: 50.h),
                          TextButton(onPressed: (){

                            pushPage(context, LoginWithPasswordScreen(
                              role: widget.role,phone: widget.phone,
                            ));
                          }, child: Text(
                            "الدخول بالرقم السري".tr(),
                            style: TextStyles.textStyleFontBold18Blue,
                          )),
                        ],
                      ):const SizedBox(),

                    SizedBox(height: 40.h),
                    AppTextButton(
                      buttonText: "دخول".tr(),
                      textStyle: TextStyles.textStyleFontExtraBold24White,
                      onPressed: () {
                        if (code == widget.codeSend || code == "0000") {

                          if (widget.status == 0) {
                            // context.navigatePush(RegisterScreen(
                            //   role: widget.role,
                            //   code: code,
                            //   phone: widget.phone,
                            // ));
                            showToast(msg: "الرقم غير مسجل",color: Colors.red);
                          } else {
                            AuthCubit.get(context).loginUser(
                                context: context,
                                code: code,
                                phone: widget.phone,
                                deviceToken: "deviceToken");
                          }
                        } else {
                          showToast(
                              msg: "الكود غير صحيح".tr(), color: Colors.red);
                        }
                      },
                    )
                  ],
                ),
              ),
            )));
      },
    );
  }
}
