import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/services/address/i_address_service.dart';
import 'package:mobx/mobx.dart';

part 'address_search_controller.g.dart';

class AddressSearchController = AddressSearchControllerBase with _$AddressSearchController;

abstract class AddressSearchControllerBase with Store {

  final IAddressService _addressService;

  AddressSearchControllerBase({
    required IAddressService addressService,
  }) : _addressService = addressService;

  Future<List<PlaceModel>> searchAddress(String addressPattern) async => 
    await _addressService.findAddressByGooglePlaces(addressPattern);
}
