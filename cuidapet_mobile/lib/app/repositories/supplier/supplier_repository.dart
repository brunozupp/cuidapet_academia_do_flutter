import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/logger/i_app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_client/i_rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client_excepiton.dart';
import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_nearby_me_model.dart';
import 'package:cuidapet_mobile/app/repositories/supplier/i_supplier_repository.dart';

class SupplierRepository implements ISupplierRepository {

  final IRestClient _restClient;
  final IAppLogger _logger;

  SupplierRepository({
    required IRestClient restClient,
    required IAppLogger logger,
  }) : _restClient = restClient,
       _logger = logger;

  @override
  Future<List<SupplierCategoryModel>> getCategories() async {
    
    try {
      final result = await _restClient.auth().get("/categories/");
      
      return result.data?.map<SupplierCategoryModel>(
        (e) => SupplierCategoryModel.fromMap(e)
      ).toList();
    } on RestClientExcepiton catch (e,s) {

      const errorMessage = "Erro ao buscar as categorias dos fornecedores";

      _logger.error(errorMessage, e, s);

      throw Failure(message: errorMessage);
    }
  }

  @override
  Future<List<SupplierNearbyMeModel>> findNearby(AddressEntity address) async {
    
    try {
      final result = await _restClient.auth().get(
        "/suppliers/",
        queryParameters: {
          "lat": address.lat,
          "lng": address.lng,
        }
      );
      
      return result.data?.map<SupplierNearbyMeModel>((e) => SupplierNearbyMeModel.fromMap(e)).toList();
    } on RestClientExcepiton catch (e, s) {
      
      const errorMessage = "Erro ao buscar fornecedores perto de mim";

      _logger.error(errorMessage, e, s);

      throw Failure(message: errorMessage);
    }
  }
  
}
