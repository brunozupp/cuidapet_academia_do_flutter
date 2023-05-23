import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_logo.dart';
import 'package:cuidapet_mobile/app/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class AuthHomePage extends StatefulWidget {

  final AuthStore _authStore;

  const AuthHomePage({
    Key? key,
    required AuthStore authStore,
  }) : 
  _authStore = authStore,
  super(key: key);

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {

  @override
  void initState() {
    super.initState();

    reaction<UserModel?>((_) => widget._authStore.userLogged, (userLogged) { 

      if(userLogged != null && userLogged.email.isNotEmpty) {
        // Vai remover todas as outras telas da stack anteriores
        Modular.to.navigate("/home");
      } else {
        Modular.to.navigate("/auth/login");
      }
    });

    // Roda ao final do carregamento da página
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      widget._authStore.loadUserLogged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CuidapetLogo(),
      ),
    );
  }
}