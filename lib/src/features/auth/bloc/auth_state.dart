part of 'auth_bloc.dart';

class AuthState {}

class AuthInitial extends AuthState {}

class EmailSended extends AuthState {
  EmailSended({
    required this.email,
  });

  final CodeConfirmModel email;
}

class CodeVerificationInProgress extends AuthState {}

class CodeVerificationSuccess extends AuthState {}

class CodeVerificationFailure extends AuthState {
  final String error;

  CodeVerificationFailure({required this.error});
}

class CodeVerificationResetState extends AuthState {}

class CreateAccountInProgress extends AuthState {}

class CreateAccountSuccess extends AuthState {}

class CreateAccountFailure extends AuthState {
  final String error;

  CreateAccountFailure({required this.error});
}

class LoginInProgress extends AuthState {}

class LoginSuccess extends AuthState {
  final String? token;

  LoginSuccess({required this.token});
}

class LoginFailure extends AuthState {
  final String error;

  LoginFailure({required this.error});
}
