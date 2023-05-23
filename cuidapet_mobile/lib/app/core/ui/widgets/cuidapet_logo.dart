import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:flutter/material.dart';

class CuidapetLogo extends StatelessWidget {
  const CuidapetLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/logo.png",
      width: 162.w,
      height: 130.h,
      fit: BoxFit.contain,
    );
  }
}