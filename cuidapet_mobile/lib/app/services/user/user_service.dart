import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_not_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_secure_storage/i_local_secure_storage.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage/i_local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/i_app_logger.dart';
import 'package:cuidapet_mobile/app/repositories/user/i_user_repository.dart';
import 'package:cuidapet_mobile/app/services/user/i_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService implements IUserService {
  
  final IAppLogger _logger;
  final IUserRepository _userRepository;
  final ILocalSecureStorage _localSecureStorage;
  final ILocalStorage _localStorage;

  UserService({
    required IAppLogger logger,
    required IUserRepository userRepository,
    required ILocalSecureStorage localSecureStorage,
    required ILocalStorage localStorage,
  }) : _logger = logger,
       _userRepository = userRepository,
       _localSecureStorage = localSecureStorage,
       _localStorage = localStorage;
  
  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    
    try {
      final firebaseAuth = FirebaseAuth.instance;
      
      // Vai verificar quais são as opções esse email tem para fazer login dentro do firebase
      final userLoggedMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);
      
      if(userLoggedMethods.isEmpty) {
        throw UserExistsException();
      }
      
      // Cadastrando dentro do backend
      await _userRepository.register(
        email: email,
        password: password,
      );
      
      // Cadastrando dentro do firebase
      final userRegisterCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      await userRegisterCredential.user?.sendEmailVerification();
    } on FirebaseException catch (e, s) {
      _logger.error("Erro ao criar usuário no firebase", e, s);

      throw Failure(message: "Erro ao criar usuário");
    }
  }
  
  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    
    try {
      final firebaseAuth = FirebaseAuth.instance;
      
      final loginMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);
      
      if(loginMethods.isEmpty) {
        throw UserNotExistsException();
      }
      
      if(loginMethods.contains("password")) {
      
        final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      
        final userVerified = userCredential.user?.emailVerified ?? false;
      
        if(!userVerified) {
          await userCredential.user?.sendEmailVerification();
          throw Failure(message: "Email não confirmado, por favor, verifique sua caixa de spam");
        }
      
        final accessToken = await _userRepository.login(
          email: email,
          password: password,
        );

        await _saveAccessToken(accessToken: accessToken);

        await _confirmLogin();

        await _getUserData();
      
      } else {
      
        throw Failure(message: "Login não pode ser feito por email e senha");
      }
    } on FirebaseAuthException catch (e, s) {

      const message = "Usuário e/ou senha inválidos";

      _logger.error("$message - FirebaseAuthException [${e.code}]", e, s);

      throw Failure(message: message);
    }
  }

  Future<void> _saveAccessToken({
    required String accessToken,
  }) async {
    _localSecureStorage.write(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY, accessToken);
  }
  
  Future<void> _confirmLogin() async {
    
    final confirmLoginModel = await _userRepository.confirmLogin();

    await _saveAccessToken(accessToken: confirmLoginModel.accessToken);

    await _localSecureStorage.write(Constants.LOCAL_STORAGE_REFRESH_TOKEN_KEY, confirmLoginModel.refreshToken);
  }
  
  Future<void> _getUserData() async {

    final userModel = await _userRepository.getUserLogged();

    await _localStorage.write<String>(Constants.LOCAL_STORAGE_USER_LOGGED_DATA_KEY, userModel.toJson());
  }
}
