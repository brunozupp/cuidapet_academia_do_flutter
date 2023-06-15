import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/logger/i_app_logger.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_loader.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_messages.dart';
import 'package:cuidapet_mobile/app/services/user/i_user_service.dart';
import 'package:mobx/mobx.dart';

part 'register_controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {

  final IAppLogger _logger;
  final IUserService _userService;

  RegisterControllerBase({
    required IAppLogger logger,
    required IUserService userService,
  }) : _logger = logger,
       _userService = userService;

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      CuidapetLoader.show();
      
      await _userService.register(email: email, password: password);
      CuidapetMessages.info("Enviamos um email de confirmação, por favor, olhe sua caixa de email");
      
    } on UserExistsException {
      CuidapetMessages.alert("Email já utilizado, por favor, escolha outro");
    } catch(e,s) {
      _logger.error("Erro ao registrar usuário", e, s);
      CuidapetMessages.alert("Email já utilizado, por favor, escolha outro");
    } finally {
      CuidapetLoader.hide();
    }
  }
}
