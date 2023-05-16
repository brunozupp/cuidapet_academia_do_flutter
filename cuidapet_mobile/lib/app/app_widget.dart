import 'package:cuidapet_mobile/app/core/ui/ui_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:asuka/asuka.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppWidget extends StatelessWidget {

  const AppWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Modular.setInitialRoute("/auth");

    Modular.setObservers([
      Asuka.asukaHeroController, //This line is needed for the Hero widget to work
    ]);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context,child) => MaterialApp.router(
        title: UiConfig.title,
        debugShowCheckedModeBanner: false,
        builder: Asuka.builder,
        theme: UiConfig.theme,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    ); 
  }
}