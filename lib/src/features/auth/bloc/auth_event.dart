part of 'auth_bloc.dart';

class AuthEvent {}

class SendEmail extends AuthEvent {
  final String email;

  SendEmail(this.email);
}

class CodeVerificationStarted extends AuthEvent {
  final String email;
  final String code;

  CodeVerificationStarted({required this.email, required this.code});
}

class SendCode extends AuthEvent {
  final String email;
  final int code;

  SendCode({required this.email, required this.code});
}

class CodeVerificationReset extends AuthEvent {}

class CreateAccountStarted extends AuthEvent {
  final UserRegistrModel userModel;

  CreateAccountStarted({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
    required int gender,
    required String avatar,
    required String bio,
  }) : userModel = UserRegistrModel(
          firstName: firstName,
          lastName: lastName,
          username: username,
          email: email,
          password: password,
          gender: gender,
          avatar: avatar,
          bio: bio,
        );
}

class LoginStarted extends AuthEvent {
  final String username;
  final String password;

  LoginStarted({required this.username, required this.password});
}
