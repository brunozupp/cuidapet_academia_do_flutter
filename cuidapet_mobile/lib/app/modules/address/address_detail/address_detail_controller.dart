import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_loader.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/services/address/i_address_service.dart';
import 'package:mobx/mobx.dart';

part 'address_detail_controller.g.dart';

class AddressDetailController = AddressDetailControllerBase with _$AddressDetailController;

abstract class AddressDetailControllerBase with Store {
 
  final IAddressService _addressService;

  @readonly
  AddressEntity? _addressEntity;

  AddressDetailControllerBase({
    required IAddressService addressService,
  }) : _addressService = addressService;

  Future<void> saveAddress(PlaceModel place, String additional) async {

    CuidapetLoader.show();

    final addressEntity = await _addressService.saveAddress(place, additional);

    CuidapetLoader.hide();

    _addressEntity = addressEntity;
  }
}
