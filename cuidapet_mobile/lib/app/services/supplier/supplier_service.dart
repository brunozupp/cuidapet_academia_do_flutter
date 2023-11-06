import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
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
  
}
