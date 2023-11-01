import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:cuidapet_mobile/app/modules/home/widgets/home_appbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageLifeCycleState<HomeController, HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      backgroundColor: Colors.grey[100],
      body: NestedScrollView( // Esse cara herda todos os scrollviews. É utilizado para performance quando tenho muitos scrolls numa única tela
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            HomeAppbar(),
          ];
        }, 
        body: Container(),
      ),
    );
  }
}