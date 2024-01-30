import 'package:em_school/core/extensions/extensions_routing.dart';
import 'package:flutter/material.dart';



class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      minWidth: 40,
      height: 40,
        onPressed: () {
          context.navigatePop();
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ));
  }
}
