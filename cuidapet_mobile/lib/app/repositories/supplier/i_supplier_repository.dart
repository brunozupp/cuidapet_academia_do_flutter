import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';

abstract class ISupplierRepository {

  Future<List<SupplierCategoryModel>> getCategories();
}