import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_nearby_me_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_services_model.dart';
import 'package:cuidapet_mobile/app/repositories/supplier/i_supplier_repository.dart';
import 'package:cuidapet_mobile/app/services/supplier/i_supplier_service.dart';

class SupplierService implements ISupplierService {

  final ISupplierRepository _supplierRepository;

  SupplierService({
    required ISupplierRepository supplierRepository,
  }) : _supplierRepository = supplierRepository;

  @override
  Future<List<SupplierCategoryModel>> getCategories() async {
    return await _supplierRepository.getCategories();
  }

  @override
  Future<List<SupplierNearbyMeModel>> findNearby(AddressEntity address) async {
    return await _supplierRepository.findNearby(address);
  }

  @override
  Future<SupplierModel> findById(int id) async {
    return await _supplierRepository.findById(id);
  }

  @override
  Future<List<SupplierServicesModel>> findServices(int supplierId) async {
    return await _supplierRepository.findServices(supplierId);
  }
  
}
