import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
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

}
