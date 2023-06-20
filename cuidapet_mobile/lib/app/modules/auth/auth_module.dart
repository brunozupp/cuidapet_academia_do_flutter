import 'package:cuidapet_mobile/app/modules/auth/home/auth_home_page.dart';
import 'package:cuidapet_mobile/app/modules/auth/login/login_module.dart';
import 'package:cuidapet_mobile/app/modules/auth/register/register_module.dart';
import 'package:cuidapet_mobile/app/repositories/user/i_user_repository.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:cuidapet_mobile/app/services/user/i_user_service.dart';
import 'package:cuidapet_mobile/app/services/user/user_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {

   @override
   List<Bind> get binds => [
    Bind.lazySingleton<IUserRepository>((i) => UserRepository(
      logger: i(),
      restClient: i(),
    )),
    Bind.lazySingleton<IUserService>((i) => UserService(
      logger: i(),
      userRepository: i(),
      localSecureStorage: i(),
      localStorage: i(),
    )),
   ];

   @override
   List<ModularRoute> get routes => [
      ChildRoute(Modular.initialRoute, child: (_, __) {
        return AuthHomePage(
          authStore: Modular.get(),
        );
      }),

      ModuleRoute("/login", module: LoginModule()),

      ModuleRoute("/register", module: RegisterModule()),
   ];

}