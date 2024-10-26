import 'package:bibinto/src/features/auth/model/code_confirmation_model.dart';
import 'package:bibinto/src/features/auth/model/user_registr_model.dart';

abstract interface class AbstractAuthRepository {
  Future<CodeConfirmModel> getSignUpEmailCode({String? email});

  Future<CodeConfirmModel> verifyEmail({String? email, int? code});

  Future<UserRegistrModel> createAccount({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? password,
    int? gender,
    String? avatar,
    String? bio,
  });

  Future<UserRegistrModel> login({String? username, String? password});
}
