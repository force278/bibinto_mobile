import 'package:json_annotation/json_annotation.dart';

part 'user_registr_model.g.dart';

@JsonSerializable()
class UserRegistrModel {
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;
  final String? password;
  final int? gender;
  final String? avatar;
  final String? bio;
  final String? birthDate;

  final bool? ok;
  final String? error;
  final String? id;
  final String? token;

  UserRegistrModel(
      {this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.password,
      this.gender,
      this.avatar,
      this.bio,
      this.birthDate,
      this.ok,
      this.error,
      this.id,
      this.token});

  UserRegistrModel copyWith({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? password,
    int? gender,
    String? avatar,
    String? bio,
    String? birthDate,
    bool? ok,
    String? error,
    String? id,
    String? token,
  }) {
    return UserRegistrModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      birthDate: birthDate ?? this.birthDate,
      ok: ok ?? this.ok,
      error: error ?? this.error,
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }

  factory UserRegistrModel.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegistrModelToJson(this);
}
