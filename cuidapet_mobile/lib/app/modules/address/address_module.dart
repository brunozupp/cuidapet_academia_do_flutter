import 'package:cuidapet_mobile/app/modules/address/address_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddressModule extends Module {

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute, child: (_,__) => const AddressPage()),
  ];

}