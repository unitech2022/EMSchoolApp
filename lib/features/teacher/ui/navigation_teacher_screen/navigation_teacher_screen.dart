import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:em_school/core/helpers/helper_functions.dart';
import 'package:em_school/core/theming/colors.dart';
import 'package:em_school/core/utlis/app_model.dart';
import 'package:em_school/core/widgets/circular_progress.dart';
import 'package:em_school/core/widgets/custom_button.dart';
import 'package:em_school/core/widgets/text_field_widget.dart';
import 'package:em_school/features/teacher/ui/add_data_screens/add_lesson_screen/add_lesson_screen.dart';
import 'package:em_school/features/teacher/ui/add_data_screens/add_unit_screen/add_unit_screen.dart';
import 'package:em_school/features/teacher/ui/navigation_teacher_screen/screens_nav/aboute_screen/aboute_screen.dart';
import 'package:em_school/features/teacher/ui/navigation_teacher_screen/screens_nav/home_teacher_screen/home_teacher_screen.dart';
import 'package:em_school/features/teacher/ui/navigation_teacher_screen/screens_nav/lessons_screen/lessons_screen.dart';
import 'package:em_school/features/teacher/ui/navigation_teacher_screen/screens_nav/notifications_teacher_screen/notifications_teacher_screen.dart';
import 'package:em_school/features/teacher/ui/navigation_teacher_screen/screens_nav/students_screen/students_screen.dart';
import 'package:em_school/features/teacher/ui/navigation_teacher_screen/widgets/nav_bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/image_network_widget.dart';
import '../../../student/ui/navigation_student_screen/navigation_student_screen.dart';
import '../../bloc/teacher_cubit/teacher_cubit.dart';

class NavigationTeacherScreen extends StatefulWidget {
  const NavigationTeacherScreen({super.key});

  @override
  State<NavigationTeacherScreen> createState() =>
      _NavigationTeacherScreenState();
}

class _NavigationTeacherScreenState extends State<NavigationTeacherScreen> {

    final _key = GlobalKey<ScaffoldState>();
  final List<Widget> _screens = [
    const LessonsScreen(),
    const StudentsScreen(),
    const HomeTeacherScreen(),
    const NotificationsTeacherScreen(),
    const AbouteScreen()
  ];

  final _nameArCourseController = TextEditingController();
  final _nameEngCourseController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TeacherCubit.get(context)
        .getHomeData(context: context, userId: currentUser!.user.id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameArCourseController.dispose();
    _nameEngCourseController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherCubit, TeacherState>(
      builder: (context, state) {
        switch (state.getHomeTeacherState) {
          case RequestState.loading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case RequestState.loaded:
            return Scaffold(
          key: _key,
                 drawer: const DrawerWidget(),
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
                        state.homeTeacherResponse!.teacher.fullName,
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
              floatingActionButton: FloatingActionButton.small(
                onPressed: () {
                  // todo : Add your onPressed code here!

                  bottomSheetAddData(context);
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              bottomNavigationBar: NavBottomWidget(
                currentNavIndex: state.currentNavIndex,
                list: screensItemsTeacher,
                onTap: (value) {
                  TeacherCubit.get(context).changeCurrentIndexNav(value);
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

  void bottomSheetAddData(BuildContext context) {
    int idAdd = 0;
    return showBottomSheetWidget(context,
        BlocBuilder<TeacherCubit, TeacherState>(
      builder: (contextBloc, state) {
        return StatefulBuilder(
          builder: (BuildContext context,
              void Function(void Function()) setStateSheet) {
            return Container(
              padding: const EdgeInsets.only(
                  top: 40, left: 30, right: 30, bottom: 20),
              decoration: const BoxDecoration(
                  color: ColorsApp.boomSheetColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              height: context.height / 2,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // icon back
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          pop(context);
                        },
                      ),
                      const Spacer(),
                      Text(
                        "اضافة",
                        style: TextStyles.textStyleFontBold22White,
                      ),
                      const Spacer()
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // body ======================================================================

                  idAdd != 1
                      ? Column(
                          children: [
                          {"name": "اضافة كورس", "id": 1},
                          {"name": "اضافة وحدة", "id": 2},
                          {"name": "اضافة درس", "id": 3}
                        ]
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      int id = int.parse(
                                          e.entries.last.value.toString());
                                      if (id == 2) {
                                         pop(context);
                                        context.navigatePush(AddUnitScreen(
                                            courses: state
                                                .homeTeacherResponse!.courses));
                                       
                                      }else if (id == 3){
                                         pop(context);
                                        context.navigatePush(AddLessonScreen(
                                          units: state.homeTeacherResponse!.unitResponses,
                                            courses: state
                                                .homeTeacherResponse!.courses));
                                      }
                                      setStateSheet(() {
                                        idAdd = id;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.h),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey,
                                                width: .3.h)),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            e.entries.first.value.toString(),
                                            style: TextStyles
                                                .textStyleFontMeduim19White,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList())
                      : Column(
                          children: [
                            TextFormFieldWidget(
                              isObscureText: false,
                              backgroundColor: ColorsApp.boomSheetColor,
                              hintText: " اسم الكورس باللغة العربية",
                              validator: (val) {},
                              controller: _nameArCourseController,
                            ),
                            verticalSpace(20.h),
                            TextFormFieldWidget(
                              isObscureText: false,
                              backgroundColor: ColorsApp.boomSheetColor,
                              hintText: " اسم الكورس باللغة الانجليزية",
                              validator: (val) {},
                              controller: _nameEngCourseController,
                            ),
                            verticalSpace(20.h),
                            state.addCourseState == RequestState.loading
                                ? const CustomCircularProgress()
                                : CustomButton(
                                    title: "اضافة",
                                    onPressed: () {
                                      if (isValidateCourse(context)) {
                                        TeacherCubit.get(context).addCourse(
                                            context: context,
                                            nameAr:
                                                _nameArCourseController.text,
                                            nameEng:
                                                _nameEngCourseController.text);
                                      }
                                    })
                          ],
                        )
                ],
              ),
            );
          },
        );
      },
    ));
  }

  bool isValidateCourse(BuildContext context) {
    if (_nameArCourseController.text.isEmpty) {
      showToast(msg: "اكتب الاسم باللغة العربية");
      return false;
    } else if (_nameEngCourseController.text.isEmpty) {
      showToast(msg: "اكتب الاسم باللغة الانجليزية");
      return false;
    } else {
      return true;
    }
  }


}
