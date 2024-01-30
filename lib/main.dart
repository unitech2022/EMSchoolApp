import 'package:easy_localization/easy_localization.dart';
import 'package:em_school/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/utlis/session_manager.dart';
import 'em_school.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
 await SessionManager().getUserData();
  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.library == 'image resource service' &&
        details.exception.toString().contains('404')) {

      return;
    }
    FlutterError.presentError(details);
  };
  runApp( EasyLocalization(
      supportedLocales: const [Locale("ar"), Locale("en")],
      path: "assets/i18n",
      // <-- change the path of the translation files
      fallbackLocale: const Locale("ar"),
      startLocale: const Locale("ar"),
      child: EMSchoolApp(appRouter: AppRouter(),)) );
}


