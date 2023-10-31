import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_loader.dart';
import 'package:cuidapet_mobile/app/services/address/i_address_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifeCycle {

  final IAddressService _addressService;

  @readonly
  AddressEntity? _addressEntity;

  HomeControllerBase({
    required IAddressService addressService,
  }) : _addressService = addressService;

  @override
  Future<void> onReady() async {
    
    CuidapetLoader.show();

    await _getAddressSelected();

    CuidapetLoader.hide();
  }

  @action
  Future<void> _getAddressSelected() async {
    _addressEntity ??= await _addressService.getAddressSelected();
  
    if(_addressEntity == null) {
      await goToAddressPage();
    }
  }

  @action
  Future<void> goToAddressPage() async {
    final address = await Modular.to.pushNamed<AddressEntity>("/address/");
    _addressEntity = address;
  }

}