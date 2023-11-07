import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_nearby_me_model.dart';

abstract class ISupplierRepository {

  Future<List<SupplierCategoryModel>> getCategories();

  Future<List<SupplierNearbyMeModel>> findNearby(AddressEntity address);
}