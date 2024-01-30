
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../common/models/nav_model.dart';




class NavBottomWidget extends StatelessWidget {
  final int currentNavIndex;
  final List<NavModel> list;
final void Function(int) onTap;
   const NavBottomWidget({super.key, required this.currentNavIndex, required this.list,required this.onTap});


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        elevation: 0,
        currentIndex:currentNavIndex,
        fixedColor: ColorsApp.activeNavColor,
        enableFeedback: false,
        selectedLabelStyle:   TextStyles.textStyleFontBold16whit,
        unselectedLabelStyle:  TextStyles.textStyleFontBold15whit,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: ColorsApp.unActiveNavColor,
        showUnselectedLabels: true,

        backgroundColor: ColorsApp.backgroundColor,
        unselectedIconTheme:
        const IconThemeData(color: Color(0xffADADAD)),
        onTap: onTap,
        items: list.map((e) => buildBottomNavigationBarItem(e,currentNavIndex)).toList());
  }



  BottomNavigationBarItem buildBottomNavigationBarItem(
      NavModel model,int currentNavIndex
      ) {
    return BottomNavigationBarItem(

            icon: SvgPicture.asset(
              model.image,
              height: 31.h,width: 31.w,
              colorFilter: ColorFilter.mode(currentNavIndex ==model.index
                  ?  ColorsApp.activeNavColor
                  :  ColorsApp.unActiveNavColor, BlendMode.srcIn),

            ),
            label: model.name);
  }
}





