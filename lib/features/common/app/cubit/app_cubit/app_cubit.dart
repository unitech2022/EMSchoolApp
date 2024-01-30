import 'package:em_school/core/routing/routes.dart';
import 'package:em_school/features/common/auth/ui/screens/select_type_account_screen/select_type_account_screen.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/utlis/api_constatns.dart';
import '../../../../../core/utlis/app_model.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  changeLang(lang, context) async {
    AppModel.lang = lang;
    await saveData(ApiConstants.langKey, lang);
    // EasyLocalization.of(context)?.setLocale(Locale(lang, ''));

    //  pushPageRoutName(context,  GlobalPath.chooseLoginRegister);
    emit(AppState(changLang: lang));
  }

  getLang() {
    if (AppModel.lang == "") {
      emit(AppState(changLang: "ar"));
    } else {
      emit(AppState(changLang: AppModel.lang));
    }
  }

  getPage(context) {

    Future.delayed(const Duration(seconds: 2), () {



        if (isLogin()) {
          if (currentUser!.user.role != "") {
            if (currentUser!.user.role == AppModel.studentRole) {
              pushPageRoutName(context, Routes.navStudent);
            } else  if (currentUser!.user.role == AppModel.teacherRole) {
             pushPageRoutName(context, Routes.navTeacher);
            }
          }
      }else {
          pushPage(context, const SelectTypeAccountScreen());
        }
      // FlutterNativeSplash.remove();
      emit(AppState(page: "done"));
    });
  }



}
