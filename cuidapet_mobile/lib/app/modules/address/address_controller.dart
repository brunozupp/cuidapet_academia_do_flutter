import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_loader.dart';
import 'package:cuidapet_mobile/app/services/address/i_address_service.dart';
import 'package:mobx/mobx.dart';

part 'address_controller.g.dart';

class AddressController = AddressControllerBase with _$AddressController;

abstract class AddressControllerBase with Store, ControllerLifeCycle {

  final IAddressService _addressService;

  @readonly
  List<AddressEntity> _addresses = [];

  AddressControllerBase({
    required IAddressService addressService,
  }) : _addressService = addressService;

  @override
  void onReady() {
    getAddresses();
  }

  @action
  Future<void> getAddresses() async {
    CuidapetLoader.show();

    _addresses = await _addressService.getAddress();

    CuidapetLoader.hide();
  }
}
