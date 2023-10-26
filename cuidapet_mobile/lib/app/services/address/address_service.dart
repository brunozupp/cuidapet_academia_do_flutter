import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
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

  @override
  Future<void> deleteAll() async => _addressRepository.deleteAll();

  @override
  Future<List<AddressEntity>> getAddress() async => _addressRepository.getAddress();
  
  @override
  Future<AddressEntity> saveAddress(PlaceModel place, String additional) async {
    final entity = AddressEntity(
      address: place.address, 
      lat: place.lat, 
      lng: place.lng, 
      additional: additional,
    );

    final addressId = await _addressRepository.saveAddress(entity);

    return entity.copyWith(
      id: () => addressId,
    );
  }


  
}
