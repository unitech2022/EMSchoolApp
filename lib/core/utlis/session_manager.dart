import 'dart:convert';


import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/utlis/api_constatns.dart';
import 'package:em_school/core/utlis/app_model.dart';
import 'package:em_school/features/common/auth/ui/screens/select_type_account_screen/select_type_account_screen.dart';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/common/models/user_response.dart';

class SessionManager {
  Future<void> setUserData(Map<String, dynamic> user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString('userData', json.encode(user));
  }

  Future<void> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString('userData');
    if (data != null) {
      Map<String, dynamic> json = jsonDecode(pref.getString('userData')!);
      currentUser = UserResponse.fromJson(json);
        AppModel.lang=pref.getString(ApiConstants.langKey)??"";
      if (kDebugMode) {
        print(AppModel.lang);
      }
    }

    AppModel.lang = pref.getString('lang') ?? AppModel.langAr;
  }

  Future singOut({context}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('userData');
    currentUser = null;
    pushPage(context,const SelectTypeAccountScreen());
  }

  Future<void> setData(String key, String data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString(key, data);
  }
}
