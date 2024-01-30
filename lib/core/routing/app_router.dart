import 'package:em_school/core/routing/routes.dart';
import 'package:em_school/features/common/auth/ui/screens/select_type_account_screen/select_type_account_screen.dart';
import 'package:em_school/features/common/auth/ui/screens/splash_screen/splash_screen.dart';
import 'package:em_school/features/student/bloc/student_cubit/student_cubit.dart';

import 'package:em_school/features/student/ui/navigation_student_screen/navigation_student_screen.dart';


import 'package:em_school/features/teacher/ui/navigation_teacher_screen/navigation_teacher_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/student/ui/navigation_student_screen/screens_nav/home_screen_student/home_screen_student.dart';
import '../../features/teacher/ui/navigation_teacher_screen/screens_nav/home_teacher_screen/home_teacher_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.selectTypeAccount:
        return MaterialPageRoute(
            builder: (_) => const SelectTypeAccountScreen());

      case Routes.navTeacher:
        return MaterialPageRoute(builder: (_) => NavigationTeacherScreen());

      case Routes.navStudent:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider<StudentCubit>(
              create: (context) => StudentCubit(),
              child: NavigationStudentScreen(),
            ));

      case Routes.homeStudent:
        return MaterialPageRoute(builder: (_) => const HomeScreenStudent());

      case Routes.homeTeacher:
        return MaterialPageRoute(builder: (_) => const HomeTeacherScreen());
      default:
        return CupertinoPageRoute(builder: (context) =>
        const Scaffold(
          body: Center(
            child: Text('404'),
          ),
        ));
    }
  }
}
