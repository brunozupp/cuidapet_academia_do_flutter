import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_loader.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/services/address/i_address_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

part 'address_controller.g.dart';

class AddressController = AddressControllerBase with _$AddressController;

abstract class AddressControllerBase with Store, ControllerLifeCycle {

  final IAddressService _addressService;

  @readonly
  ObservableList<AddressEntity> _addresses = ObservableList.of([]);

  @readonly
  var _locationServiceUnavailable = false.obs();

  @readonly
  Observable<LocationPermission>? _locationPermission;

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

    _addresses = ObservableList.of(await _addressService.getAddress());

    CuidapetLoader.hide();
  }

  @action
  Future<void> myLocation() async {

    _locationPermission = null;
    
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled) {
      _locationServiceUnavailable = true.obs();
      return;
    }

    final locationPermission = await Geolocator.checkPermission();

    switch(locationPermission) {
      case LocationPermission.denied:
        final permission = await Geolocator.requestPermission();

        if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
          _locationPermission = Observable(permission);
          return;
        }
        break;
      case LocationPermission.deniedForever:
        _locationPermission = Observable(locationPermission);
        return;
      case LocationPermission.whileInUse:
      case LocationPermission.always:
      case LocationPermission.unableToDetermine:
        break;
    }

    CuidapetLoader.show();

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final placemark = await placemarkFromCoordinates(position.latitude, position.longitude);

    final place = placemark.first;

    final address = "${place.thoroughfare} ${place.subThoroughfare}";

    final placeModel = PlaceModel(
      address: address, 
      lat: position.latitude, 
      lng: position.longitude,
    );

    CuidapetLoader.hide();

    goToAddressDetail(placeModel);
  }

  void goToAddressDetail(PlaceModel place) {
    Modular.to.pushNamed("/address/detail/", arguments: place);
  }
}
