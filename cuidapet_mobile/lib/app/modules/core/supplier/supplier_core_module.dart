import 'package:cuidapet_mobile/app/repositories/supplier/i_supplier_repository.dart';
import 'package:cuidapet_mobile/app/repositories/supplier/supplier_repository.dart';
import 'package:cuidapet_mobile/app/services/supplier/i_supplier_service.dart';
import 'package:cuidapet_mobile/app/services/supplier/supplier_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SupplierCoreModule extends Module {
  
  @override
  List<Bind<Object>> get binds => [
    Bind.lazySingleton<ISupplierRepository>(
      (i) => SupplierRepository(
        restClient: i(),
        logger: i()), 
      export: true,
    ),
    Bind.lazySingleton<ISupplierService>(
      (i) => SupplierService(
        supplierRepository: i()), 
      export: true,
    ),
  ];
}