import 'package:em_school/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/cubit/app_cubit/app_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

AppCubit.get(context).getPage(context);

  }

  @override
  Widget build(BuildContext context) {
    // final appcastURL =
    //     'https://raw.githubusercontent.com/unitech2022/HattliApp/main/Appcast.xml';
    // final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorsApp.mainColor,
          body: Container(
            alignment: Alignment.center,
            child:  Stack(
              children: [
               Image.asset("assets/images/splashs.png",fit: BoxFit.cover,),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
