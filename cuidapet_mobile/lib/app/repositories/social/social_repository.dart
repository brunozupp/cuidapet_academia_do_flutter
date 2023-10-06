import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/models/social_network_model.dart';
import 'package:cuidapet_mobile/app/repositories/social/i_social_repository.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialRepository implements ISocialRepository {

  @override
  Future<SocialNetworkModel> facebookLogin() async {
    
    final facebookAuth = FacebookAuth.instance;

    final result = await facebookAuth.login();

    switch(result.status) {
      case LoginStatus.success:
        final userData = await facebookAuth.getUserData();

        return SocialNetworkModel(
          id: userData["id"], 
          name: userData["name"], 
          email: userData["email"], 
          type: "Facebook",
          avatar: userData["picture"]["data"]["url"], 
          accessToken: result.accessToken?.token ?? ""
        );
      case LoginStatus.cancelled:
        throw Failure(message: "Login cancelado");
      case LoginStatus.failed:
      case LoginStatus.operationInProgress:
        throw Failure(message: result.message);
    }
  }

  @override
  Future<SocialNetworkModel> googleLogin() async {
    
    final googleSignIn = GoogleSignIn();

    if(await googleSignIn.isSignedIn()) {
      // Para que sempre abra a caixinha com os emails para selecionar.
      // Se não colocar isso, ele sempre vai pegar o último selecionado
      // que ficou em cache e não vai abrir a caixinha de escolha.
      await googleSignIn.disconnect();
    }

    // Vai abrir a caixinha
    final googleUser = await googleSignIn.signIn();

    // Pegar as informações do usuário logado
    final googleAuth = await googleUser?.authentication;

    if(googleAuth != null && googleUser != null) {
      return SocialNetworkModel(
        id: googleAuth.idToken ?? "", 
        name: googleUser.displayName ?? "", 
        email: googleUser.email, 
        type: "Google",
        avatar: googleUser.photoUrl,
        accessToken: googleAuth.accessToken ?? "",
      );
    } else {
      throw Failure(
        message: "Erro realizar login com o Google",
      );
    }
  }

}