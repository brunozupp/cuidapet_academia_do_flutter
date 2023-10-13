import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/repositories/address/i_address_repository.dart';
import 'package:cuidapet_mobile/app/services/address/i_address_service.dart';

class AddressService implements IAddressService {

  final IAddressRepository _addressRepository;

  AddressService({
    required IAddressRepository addressRepository,
  }) : _addressRepository = addressRepository;

  @override
  Future<List<PlaceModel>> findAddressByGooglePlaces(String addressPattern) async {
    return await _addressRepository.findAddressByGooglePlaces(addressPattern);
  }
  
}
