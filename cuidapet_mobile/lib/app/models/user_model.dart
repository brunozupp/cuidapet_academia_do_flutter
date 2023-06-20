import 'dart:convert';

class UserModel {
  
  final String email;
  final String registerType;
  final String imgAvatar;
  
  UserModel({
    required this.email,
    required this.registerType,
    required this.imgAvatar,
  });

  UserModel.empty() :
    email = "",
    registerType = "",
    imgAvatar = "";

  UserModel copyWith({
    String? email,
    String? registerType,
    String? imgAvatar,
  }) {
    return UserModel(
      email: email ?? this.email,
      registerType: registerType ?? this.registerType,
      imgAvatar: imgAvatar ?? this.imgAvatar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'register_type': registerType,
      'img_avatar': imgAvatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      registerType: map['register_type'] ?? '',
      imgAvatar: map['img_avatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(email: $email, registerType: $registerType, imgAvatar: $imgAvatar)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.email == email &&
      other.registerType == registerType &&
      other.imgAvatar == imgAvatar;
  }

  @override
  int get hashCode => email.hashCode ^ registerType.hashCode ^ imgAvatar.hashCode;
}
