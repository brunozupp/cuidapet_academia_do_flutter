import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';

abstract class IAddressService {
  
  Future<List<PlaceModel>> findAddressByGooglePlaces(String addressPattern);

  Future<List<AddressEntity>> getAddress();

  Future<AddressEntity> saveAddress(PlaceModel place, String additional);

  Future<void> deleteAll();
}