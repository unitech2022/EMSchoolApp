import 'package:easy_localization/easy_localization.dart';
import 'package:em_school/core/enums/loading_status.dart';
import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/theming/colors.dart';
import 'package:em_school/core/utlis/session_manager.dart';
import 'package:em_school/features/student/bloc/student_cubit/student_cubit.dart';
import 'package:em_school/features/student/ui/navigation_student_screen/screens_nav/home_screen_student/home_screen_student.dart';
import 'package:em_school/features/student/ui/navigation_student_screen/screens_nav/notifications_student_screen/notifications_student_screen.dart';
import 'package:em_school/features/student/ui/navigation_student_screen/screens_nav/subects_screen/subects_screen.dart';
import 'package:em_school/features/student/ui/navigation_student_screen/screens_nav/tables_screen/tables_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utlis/app_model.dart';
import '../../../../core/widgets/image_network_widget.dart';
import '../../../teacher/ui/navigation_teacher_screen/screens_nav/aboute_screen/aboute_screen.dart';
import '../../../teacher/ui/navigation_teacher_screen/widgets/nav_bottom_widget.dart';

class NavigationStudentScreen extends StatefulWidget {
  const NavigationStudentScreen({super.key});

  @override
  State<NavigationStudentScreen> createState() =>
      _NavigationStudentScreenState();
}

class _NavigationStudentScreenState extends State<NavigationStudentScreen> {
  final _key = GlobalKey<ScaffoldState>();
  final List<Widget> _screens = [
    const SubjectsScreen(),
    const TablesScreen(),
    const HomeScreenStudent(),
    const NotificationsStudentScreen(),
    const AbouteScreen()
  ];

  @override
  void initState() {
    super.initState();
    StudentCubit.get(context)
        .getHomeData(context: context, userId: currentUser!.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentCubit, StudentState>(
      builder: (context, state) {
        switch (state.getHomeUserState) {
          case RequestState.loading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case RequestState.loaded:
            return Scaffold(
              key: _key,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                centerTitle: false,
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageNetworkWidget(
                        height: 30.h,
                        width: 30.w,
                        image: "state.homeResponse.i",
                        errorWidget: Image.asset("assets/images/e.png"),
                      ),
                      horizontalSpace(10.w),
                      Text(
                        state.homeResponse!.user.fullName,
                        style: TextStyles.textStyleFontLight22White,
                      )
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      _key.currentState!.openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              extendBody: true,
              drawer: const DrawerWidget(),
              bottomNavigationBar: NavBottomWidget(
                currentNavIndex: state.currentNavIndex,
                list: screensItemsStudent,
                onTap: (value) {
                  StudentCubit.get(context).changeCurrentIndexNav(value);
                },
              ),
              body: IndexedStack(
                index: state.currentNavIndex,
                children: _screens,
              ),
            );
          case RequestState.error:
            return const Scaffold(
                body: Center(
              child: Text("error"),
            ));
          case RequestState.noInternet:
            return const Scaffold(
                body: Center(
              child: Text("notEnternet"),
            ));
          default:
            return const Scaffold(
              body: Center(
                child: Text("error"),
              ),
            );
        }
      },
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: ColorsApp.backgroundColor,
      child: Column(
        children: [
          SizedBox(
            height: context.height/3,
            width: double.infinity,
            child: Image.asset(
              "assets/images/app_icon.png",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          verticalSpace(30.h),
          MaterialButton(
            height: 60.h,
            onPressed: ()async {
              await SessionManager().singOut(context: context);
            },
            child: Row(
              children: [
                const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                horizontalSpace(20.w),
                Text(
                  "تسجيل الخروج".tr(),
                  style: TextStyles.textStyleFontBold20White,
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
