import 'package:cuidapet_mobile/app/core/logger/i_app_logger.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_loader.dart';
import 'package:cuidapet_mobile/app/services/user/i_user_service.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  
  final IUserService _userService;
  final IAppLogger _logger;

  _LoginControllerBase({
    required IUserService userService,
    required IAppLogger logger,
  }) : _userService = userService,
       _logger = logger;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {

      CuidapetLoader.show();
      
    } catch (e) {
      
    } finally {
      CuidapetLoader.hide();
    }
  }
}
