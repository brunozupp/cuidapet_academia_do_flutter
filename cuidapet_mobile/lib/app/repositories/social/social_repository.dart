import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/models/social_network_model.dart';
import 'package:cuidapet_mobile/app/repositories/social/i_social_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialRepository implements ISocialRepository {

  @override
  Future<SocialNetworkModel> facebookLogin() async {
    // TODO: implement facebookLogin
    throw UnimplementedError();
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