import 'package:easy_localization/easy_localization.dart';
import 'package:em_school/core/layout/app_fonts.dart';
import 'package:em_school/core/routing/app_router.dart';
import 'package:em_school/core/routing/routes.dart';
import 'package:em_school/core/theming/colors.dart';
import 'package:em_school/features/common/app/cubit/app_cubit/app_cubit.dart';
import 'package:em_school/features/student/bloc/lesson_cubit/lesson_cubit.dart';
import 'package:em_school/features/student/bloc/student_cubit/student_cubit.dart';
import 'package:em_school/features/student/bloc/subject_cubit/subject_cubit.dart';
import 'package:em_school/features/teacher/bloc/teacher_cubit/teacher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/common/auth/cubit/auth_cubit.dart';
import 'features/student/bloc/favoraite_cubit/favoraite_cubit.dart';

class EMSchoolApp extends StatelessWidget {
  final AppRouter appRouter;
  const EMSchoolApp({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(468, 963),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(create: (BuildContext context) => AppCubit()),
          BlocProvider<AuthCubit>(create: (BuildContext context) => AuthCubit()),
          BlocProvider<TeacherCubit>(create: (BuildContext context) => TeacherCubit()),
          BlocProvider<StudentCubit>(create: (BuildContext context) => StudentCubit()),
          BlocProvider<SubjectCubit>(create: (BuildContext context) => SubjectCubit()),
          BlocProvider<LessonCubit>(create: (BuildContext context) => LessonCubit()),
          BlocProvider<FavoriteCubit>(
              create: (BuildContext context) => FavoriteCubit()),
        ],
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'EMSchool',
          theme: ThemeData(
            fontFamily: AppFonts.innerBold,
              appBarTheme: const AppBarTheme(
                backgroundColor: ColorsApp.backgroundColor,
                  elevation: 0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.dark
                  )
              ),
              primaryColor: ColorsApp.mainColor,

              scaffoldBackgroundColor: ColorsApp.backgroundColor
          ),
          initialRoute: Routes.splashScreen,
          onGenerateRoute: appRouter.generateRoute,
        ),
      ),
    );
  }
}
