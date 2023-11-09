import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/logger/i_app_logger.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_loader.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_messages.dart';
import 'package:cuidapet_mobile/app/models/supplier_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_services_model.dart';
import 'package:cuidapet_mobile/app/services/supplier/i_supplier_service.dart';
import 'package:mobx/mobx.dart';
part 'supplier_controller.g.dart';

class SupplierController = SupplierControllerBase with _$SupplierController;

abstract class SupplierControllerBase with Store, ControllerLifeCycle {

  final ISupplierService _supplierService;
  final IAppLogger _appLogger;

  SupplierControllerBase({
    required ISupplierService supplierService,
    required IAppLogger appLogger,
  }) : _supplierService = supplierService,
       _appLogger = appLogger;

  int _supplierId = 0;

  @readonly
  SupplierModel? _supplierModel;

  @readonly
  var _supplierServices = <SupplierServicesModel>[];

  @readonly
  // ignore: prefer_final_fields
  var _servicesSelected = <SupplierServicesModel>[].asObservable();

  @override
  void onInit([Map<String, dynamic>? params]) {
    if(params != null && params.containsKey("supplierId")) {
      _supplierId = params["supplierId"];
    }
  }

  @override
  Future<void> onReady() async {
    
    try {
      CuidapetLoader.show();
      
      await Future.wait([
        _findSupplierById(),
        _findSupplierServices(),
      ]);
    } finally {
      
      CuidapetLoader.hide();
    }
  }

  @action
  Future<void> _findSupplierById() async {

    try {
      _supplierModel = await _supplierService.findById(_supplierId);
    } catch (e,s) {
      const errorMessage = "Erro ao buscar os dados do fornecedor";
      _appLogger.error(errorMessage, e, s);

      CuidapetMessages.alert(errorMessage);
    }
  }

  @action
  Future<void> _findSupplierServices() async {

    try {
      final services = await _supplierService.findServices(_supplierId);

      _supplierServices = [...services];
    } catch (e,s) {
      const errorMessage = "Erro ao buscar os serviços do fornecedor";
      _appLogger.error(errorMessage, e, s);

      CuidapetMessages.alert(errorMessage);
    }
  }

  @action
  void addOrRemoveService(SupplierServicesModel supplierServicesModel) {
    if(_servicesSelected.contains(supplierServicesModel)) {
      _servicesSelected.remove(supplierServicesModel);
    } else {
      _servicesSelected.add(supplierServicesModel);
    }
  }

  bool isServiceSelected(SupplierServicesModel service) => _servicesSelected.contains(service);

  @computed
  int get totalServicesSelected => _servicesSelected.length;
}