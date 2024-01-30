import 'package:em_school/core/data_static/data_for_login.dart';
import 'package:em_school/core/enums/loading_status.dart';
import 'package:dio/dio.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/routing/routes.dart';
import 'package:em_school/core/utlis/api_constatns.dart';
import 'package:em_school/core/utlis/app_model.dart';
import 'package:em_school/core/utlis/session_manager.dart';
import 'package:em_school/core/utlis/utils.dart';

import 'package:em_school/features/common/auth/ui/screens/otp_screen/otp_screen.dart';
import 'package:em_school/features/common/models/subject_model.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/class_room_model.dart';
import '../../models/register_body_reqquest.dart';
import '../../models/response_data_for_login.dart';
import '../../models/stage_model.dart';
import '../../models/type_education_model.dart';
import '../../models/user_response.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  TypeEducationModel? typeEducationModel;
  StageModel? stageModel;
  ClassRoomModel? classRoomModel;
  SubjectModel? subjectModel;
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

  /// check username
  Future checkUserName({context, phone, role}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(checkUserNameState: RequestState.loading));

    var data = FormData.fromMap({'phone': phone});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/check-username',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode} + ===== > checkUserName");
    if (response.statusCode == 200) {
      pop(context);
      int status = response.data["status"];
      String code = response.data["code"];

      pushPage(
          context,
          OTPScreen(
            status: status,
            role: role,
            phone: phone,
            codeSend: code,
          ));

      emit(state.copyWith(checkUserNameState: RequestState.loaded));
    } else {
      pop(context);
      emit(state.copyWith(checkUserNameState: RequestState.error));
    }
  }

  /// login
  Future loginUser({context, deviceToken, phone, code,type=0}) async {
   if(type==0) showUpdatesLoading(context);
    emit(state.copyWith(loginState: RequestState.loading));
    var data = FormData.fromMap(
        {'DeviceToken': deviceToken, 'UserName': phone, 'code': code});

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/user-login',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    debugPrint("${response.statusCode} + ===== > loginUser");

    if (response.statusCode == 200) {
      pop(context);
      if(response.data["status"]==false){
        showToast(msg: "بيانات التسجيل غير صحيحة",color: Colors.red);
      }else{

        UserResponse userResponse= currentUser = UserResponse.fromJson(response.data);
        await   SessionManager().setUserData(userResponse.toJson());
        if(userResponse.user.role==AppModel.studentRole){
          pushPageRoutName(context, Routes.navStudent);
        }else   if(userResponse.user.role==AppModel.teacherRole){
          pushPageRoutName(context, Routes.navTeacher);
        }



        emit(state.copyWith(
            loginState: RequestState.loaded, userResponse: userResponse));
      }





    } else {
      showErrorLoading(context, "Something went wrong");
      emit(state.copyWith(loginState: RequestState.error));
    }
  }

  /// register
  Future registerUser(RequestBodyRegister registerBody,
      {context,type
     }) async {
    showUpdatesLoading(context);
    emit(state.copyWith(registerState: RequestState.loading));
    var data = FormData.fromMap({
      'userName': registerBody.userName,
      'FullName': registerBody.fullName,
      'StageId': registerBody.stageId.toString(),
      'subjectId': registerBody.subjectId.toString(),
      'Password': registerBody.password,
      'Role': registerBody.role,
      'TypeEducationId': registerBody.typeEducationId.toString(),
      'ClassRoomId': registerBody.classRoomId.toString()
    });

    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/user-signup',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );
    debugPrint("${response.statusCode} + ===== > registerUser");
    if (response.statusCode == 200) {
      loginUser(context: context,phone: registerBody.userName,code: registerBody.code,type: 1);
      emit(state.copyWith(registerState: RequestState.loaded));
    } else {
      showErrorLoading(context, "Something went wrong");
      emit(state.copyWith(registerState: RequestState.error));
    }
  }

  /// data for login
  Future getDataForLogin() async {
    emit(state.copyWith(getResponseForLoginState: RequestState.loading));
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.baseUrl}/home/get-data-for-login',
      options: Options(
        method: 'GET',
      ),
    );
    debugPrint("${response.statusCode} + ===== > getDataForLogin");

    if (response.statusCode == 200) {
      responseDataForLogin = ResponseDataForLogin.fromJson(response.data);

      emit(state.copyWith(getResponseForLoginState: RequestState.loaded));
    } else {
      emit(state.copyWith(getResponseForLoginState: RequestState.error));
    }
  }

  // change current model
  Future changeCurrentDataLogin({model, type}) async {
    emit(state.copyWith(changeDataLoginState: RequestState.loading));
    if (type == 0) {
      typeEducationModel = model;
      emit(state.copyWith(changeDataLoginState: RequestState.loaded));
    }
    if (type == 1) {
      stageModel = model;
      emit(state.copyWith(changeDataLoginState: RequestState.loaded));
    }
    if (type == 2) {
      classRoomModel = model;
      emit(state.copyWith(changeDataLoginState: RequestState.loaded));
    }

    if (type == 3) {
      subjectModel = model;
      emit(state.copyWith(changeDataLoginState: RequestState.loaded));
    }
  }
}
