import 'package:cuidapet_mobile/app/core/logger/i_app_logger.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_loader.dart';
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
    CuidapetLoader.show();


    CuidapetLoader.hide();
  }
}
