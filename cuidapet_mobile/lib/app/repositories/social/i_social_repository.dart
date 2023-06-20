import 'package:cuidapet_mobile/app/models/social_network_model.dart';

abstract class ISocialRepository {

  Future<SocialNetworkModel> googleLogin();

  Future<SocialNetworkModel> facebookLogin();
}