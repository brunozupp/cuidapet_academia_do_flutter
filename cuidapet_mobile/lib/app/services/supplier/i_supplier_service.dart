import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_nearby_me_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_services_model.dart';

abstract class ISupplierService {

  Future<List<SupplierCategoryModel>> getCategories();

  Future<List<SupplierNearbyMeModel>> findNearby(AddressEntity address);

  Future<SupplierModel> findById(int id);

  Future<List<SupplierServicesModel>> findServices(int supplierId);
}