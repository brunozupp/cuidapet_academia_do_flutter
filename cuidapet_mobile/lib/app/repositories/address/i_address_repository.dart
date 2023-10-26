import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';

abstract class IAddressRepository {
  
  Future<List<PlaceModel>> findAddressByGooglePlaces(String addressPattern);

  // Chamou de entity só para separar entidades que vem de fora para entidades
  // que trabalho localmente no banco de dados sqlite. E uma entidade está mais
  // voltada para as regras de negócio da empresa, enquanto a Model é apenas
  // para movimentação de dados
  Future<List<AddressEntity>> getAddress();

  Future<int> saveAddress(AddressEntity entity);

  Future<void> deleteAll();
}