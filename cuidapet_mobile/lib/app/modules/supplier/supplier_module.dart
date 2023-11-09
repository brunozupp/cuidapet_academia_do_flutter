import 'package:cuidapet_mobile/app/modules/core/supplier/supplier_core_module.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_controller.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_interfaces/src/route/route_context.dart';

class SupplierModule extends Module {

  @override
  List<Bind<Object>> get binds => [
    Bind.lazySingleton((i) => SupplierController(
      appLogger: i(),
      supplierService: i(),
    )),
  ];
  
  @override
  List<ModularRoute> get routes => [
    // Eu passo o supplierId através do args.data na tela para sobrescrever o get "params"
    // da classe abstrata PageLifeCycleState para que seja possível passar o valor de supplierId
    // para o método onInit de PageLifeCycleState, assim eu tenho acesso ao valor na minha Controller
    ChildRoute("/", child: (context, args) => SupplierPage(
      supplierId: args.data,
    ))
  ];

  @override
  List<RouteContext> get modules => [
    SupplierCoreModule(), // Para esse modulo ter acesso ao serviço e repositório de Supplier
  ];
}