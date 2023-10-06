import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifeCycle {

  @override
  void onInit([Map<String, dynamic>? params]) {
    print("OnInit chamado");
  }

  @override
  void onReady() {
    print("OnReady chamado");
  }
}