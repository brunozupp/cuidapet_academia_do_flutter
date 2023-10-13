import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/helpers/environments.dart';
import 'package:cuidapet_mobile/app/core/logger/i_app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_client/i_rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client_excepiton.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/repositories/address/i_address_repository.dart';

class AddressRepository implements IAddressRepository {

  final IRestClient _restClient;
  final IAppLogger _logger;

  AddressRepository({
    required IRestClient restClient,
    required IAppLogger logger,
  }) : _restClient = restClient,
       _logger = logger;
  
  @override
  Future<List<PlaceModel>> findAddressByGooglePlaces(String addressPattern) async {

    try {
      final googleApiKey = Environments.param(Constants.GOOGLE_API_KEY);
      
      if(googleApiKey == null) {
        throw Failure(message: "Google Api Key Not Found");
      }
      
      const baseUrl = "https://maps.googleapis.com/maps/api/place/textsearch/json";
      
      final response = await _restClient.unauth().get(
        baseUrl,
        queryParameters: {
          "query": addressPattern,
          "key": googleApiKey,
        }
      );

      if(response.data["results"] == null) {
        throw Failure(message: "Erro ao pegar os dados do endereço");
      }
      
      final predictions = response.data["results"] as List;
      
      return predictions.map((e) => PlaceModel(
        address: e["formatted_address"] ?? "", 
        lat: e["geometry"]?["location"]?["lat"] ?? 0, 
        lng: e["geometry"]?["location"]?["lng"] ?? 0,
      )).toList();
    } on RestClientExcepiton catch (e,s) {
      _logger.error("Erro ao pegar os dados do endereço", e, s);

      throw Failure(
        message: "Erro ao pegar os dados do endereço",
      );
    } on Failure {
      rethrow;
    }
  }
  
}