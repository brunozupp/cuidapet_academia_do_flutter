import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_secure_storage/i_local_secure_storage.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage/i_local_storage.dart';
import 'package:cuidapet_mobile/app/models/user_model.dart';
import 'package:cuidapet_mobile/app/services/address/i_address_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {

  final ILocalStorage _localStorage;
  final ILocalSecureStorage _localSecureStorage;
  final IAddressService _addressService;

  AuthStoreBase({
    required ILocalStorage localStorage,
    required ILocalSecureStorage localSecureStorage,
    required IAddressService addressService,
  }) : _localStorage = localStorage,
       _localSecureStorage = localSecureStorage,
       _addressService = addressService;

  @readonly
  UserModel? _userLogged;

  @action
  Future<void> loadUserLogged() async {
    
    // Usuário logado -------------------------------------

    final userModelJson = await _localStorage.read<String>(Constants.LOCAL_STORAGE_USER_LOGGED_DATA_KEY);

    if(userModelJson != null) {
      _userLogged = UserModel.fromJson(userModelJson);
    } else {
      _userLogged = UserModel.empty();
    }

    // Usuário executar Logout ----------------------------

    FirebaseAuth.instance.authStateChanges().listen((user) async { 
      if(user == null) {
        await logout();
      }
    });
  }

  @action
  Future<void> logout() async {
    await _localStorage.clean();
    await _localSecureStorage.clean();

    _addressService.deleteAll();    

    _userLogged = UserModel.empty();
  }
}
