import 'package:flutter/material.dart';

extension NavigateRoteres on BuildContext{
  void navigateToNamed(String route) {
    Navigator.pushNamed(this, route);
  }

  void navigatePush(Widget page) {

    Navigator.push(
      this,
      MaterialPageRoute(builder: (context) =>  page),
    );
  }
  void navigatePop() {
    Navigator.pop(this);
  }

  void navigateToAndRemoveUntil(String route) {
    Navigator.pushNamedAndRemoveUntil(this, route, (route) => false);
  }



  void navigateToAndRemoveUntilWithAnimation(String route) {
    Navigator.pushNamedAndRemoveUntil(this, route, (route) => false);
  }


  void navigateToWithAnimation(String route) {
    Navigator.pushNamed(this, route);
  }


}

extension  ScreenSizes on BuildContext{
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}