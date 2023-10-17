import 'package:cuidapet_mobile/app/core/local_storage/local_secure_storage/i_local_secure_storage.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_secure_storage/local_secure_storage.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage/i_local_storage.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/logger/i_app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_client/dio/dio_rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/i_rest_client.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:cuidapet_mobile/app/repositories/address/address_repository.dart';
import 'package:cuidapet_mobile/app/repositories/address/i_address_repository.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:cuidapet_mobile/app/services/address/i_address_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {

  @override
  List<Bind> get binds => [
    Bind.lazySingleton<AuthStore>((i) => AuthStore(
      localStorage: i(),
    ), export: true), // precisa do export para exportar para outros módulos
    Bind.lazySingleton<IRestClient>((i) => DioRestClient(
      localStorage: i(),
      logger: i(),
      authStore: i(),
      localSecureStorage: i(),
    ), export: true),
    Bind.lazySingleton<IAppLogger>((i) => AppLogger(), export: true),
    Bind.lazySingleton<ILocalStorage>((i) => LocalStorage(), export: true),
    Bind.lazySingleton<ILocalSecureStorage>((i) => LocalSecureStorage(), export: true),
    Bind.lazySingleton<IAddressRepository>((i) => AddressRepository(
      restClient: i(), 
      logger: i(),
    ), export: true),
    Bind.lazySingleton<IAddressService>((i) => AddressService(addressRepository: i()), export: true),
  ];
}