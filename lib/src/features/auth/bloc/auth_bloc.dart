import 'package:bibinto/src/features/auth/data/repository/auth_repository/abstract_auth_repository.dart';
import 'package:bibinto/src/features/auth/model/code_confirmation_model.dart';
import 'package:bibinto/src/features/auth/model/user_registr_model.dart';
import 'package:bibinto/src/common/domain/local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AbstractAuthRepository authRepository;
  final LocalStorage localStorage;
  AuthBloc(this.authRepository, this.localStorage) : super(AuthInitial()) {
    on<SendEmail>((event, emit) async {
      try {
        final sendEmail =
            await authRepository.getSignUpEmailCode(email: event.email);
        if (sendEmail.ok == true) {
          emit(EmailSended(email: sendEmail));
        } else {
          emit(
            CodeVerificationFailure(
              error: sendEmail.error.toString(),
            ),
          );
        }
      } catch (e) {
        emit(CodeVerificationFailure(error: e.toString()));
      }
    });

    on<CodeVerificationStarted>((event, emit) async {
      emit(CodeVerificationInProgress());
      try {
        final result = await authRepository.verifyEmail(
            email: event.email, code: int.parse(event.code));

        if (result.ok == true) {
          emit(CodeVerificationSuccess());
        } else {
          emit(CodeVerificationFailure(error: 'Incorrect code entered'));
        }
      } catch (e) {
        emit(CodeVerificationFailure(error: 'Error occurred: $e'));
      }
    });

    on<CodeVerificationReset>((event, emit) async {
      emit(CodeVerificationResetState());
    });

    on<CreateAccountStarted>((event, emit) async {
      emit(CreateAccountInProgress());
      try {
        final result = await authRepository.createAccount(
          firstName: event.userModel.firstName,
          lastName: event.userModel.lastName,
          username: event.userModel.username,
          email: event.userModel.email,
          password: event.userModel.password,
          gender: event.userModel.gender,
          avatar: event.userModel.avatar,
          bio: event.userModel.bio,
        );

        if (result.ok == true) {
          await localStorage.write('Token', result.token ?? '');
          emit(CreateAccountSuccess());
        } else {
          emit(CreateAccountFailure(error: 'Failed to create account'));
        }
      } catch (e) {
        emit(CreateAccountFailure(error: e.toString()));
      }
    });

    on<LoginStarted>((event, emit) async {
      emit(LoginInProgress());
      try {
        final result = await authRepository.login(
            username: event.username, password: event.password);
        if (result.ok == true) {
          await localStorage.write('Token', result.token ?? '');
          emit(LoginSuccess(token: result.token));
        } else {
          emit(LoginFailure(error: result.error ?? 'Unknown error'));
        }
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
