import 'package:cuidapet_mobile/app/core/rest_client/dio/dio_rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {

  @override
  List<Bind> get binds => [
    Bind.lazySingleton((i) => AuthStore(), export: true), // precisa do export para exportar para outros módulos
    Bind.lazySingleton<RestClient>((i) => DioRestClient(), export: true),
  ];
}