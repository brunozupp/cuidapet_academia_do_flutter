import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage/i_local_storage.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/repositories/address/i_address_repository.dart';
import 'package:cuidapet_mobile/app/services/address/i_address_service.dart';

class AddressService implements IAddressService {

  final IAddressRepository _addressRepository;
  final ILocalStorage _localStorage;

  AddressService({
    required IAddressRepository addressRepository,
    required ILocalStorage localStorage,
  }) : _addressRepository = addressRepository,
       _localStorage = localStorage;

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
  
  @override
  Future<AddressEntity?> getAddressSelected() async {
    final addressJson = await _localStorage.read<String>(
      Constants.LOCAL_STORAGE_DEFAULT_ADDRESS_DATA_KEY,
    );

    if(addressJson != null) {
      return AddressEntity.fromJson(addressJson);
    }

    return null;
  }
  
  @override
  Future<void> selectAddress(AddressEntity addressEntity) async {
    
    await _localStorage.write<String>(
      Constants.LOCAL_STORAGE_DEFAULT_ADDRESS_DATA_KEY, 
      addressEntity.toJson()
    );
  }
}
