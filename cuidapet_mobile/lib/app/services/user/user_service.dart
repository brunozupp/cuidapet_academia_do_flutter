import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_not_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/logger/i_app_logger.dart';
import 'package:cuidapet_mobile/app/repositories/user/i_user_repository.dart';
import 'package:cuidapet_mobile/app/services/user/i_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService implements IUserService {
  
  final IAppLogger _logger;
  final IUserRepository _userRepository;

  UserService({
    required IAppLogger logger,
    required IUserRepository userRepository,
  }) : _logger = logger,
       _userRepository = userRepository;
  
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
      
        
      
      } else {
      
        throw Failure(message: "Login não pode ser feito por email e senha");
      }
    } on FirebaseAuthException catch (e, s) {

      const message = "Usuário e/ou senha inválidos";

      _logger.error("$message - FirebaseAuthException [${e.code}]", e, s);

      throw Failure(message: message);
    }
  }

}
