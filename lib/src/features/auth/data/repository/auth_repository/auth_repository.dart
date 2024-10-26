import 'package:bibinto/src/graphql_config/graphql_config.dart';
import 'package:bibinto/src/features/auth/data/repository/auth_repository/abstract_auth_repository.dart';
import 'package:bibinto/src/features/auth/model/code_confirmation_model.dart';
import 'package:bibinto/src/features/auth/model/user_registr_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AuthRepository implements AbstractAuthRepository {
  static GraphQLConfig graphQLConfig = GraphQLConfig();

  @override
  Future<CodeConfirmModel> getSignUpEmailCode({String? email}) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    try {
      MutationOptions options = MutationOptions(
        document: gql('''
    mutation GetSignUpEmailCode(\$email: String!) {
      getSignUpEmailCode(email: \$email) {
        ok
        error
        id
      }
    }
  '''),
        variables: {
          'email': email,
        },
      );

      QueryResult result = await client.mutate(options);

      if (!result.hasException) {
        var data = result.data?['getSignUpEmailCode'];
        return CodeConfirmModel.fromJson(data);
      } else {
        return CodeConfirmModel(error: result.exception.toString(), ok: false);
      }
    } catch (e) {
      return CodeConfirmModel(error: e.toString(), ok: false);
    }
  }

  @override
  Future<CodeConfirmModel> verifyEmail({String? email, int? code}) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    try {
      MutationOptions options = MutationOptions(
        document: gql('''
   mutation VerifyEmail(\$email: String!, \$code: Int!) {
  verifyEmail(email: \$email, code: \$code) {
    ok
    error
    id
  }
}
  '''),
        variables: {
          'email': email,
          'code': code,
        },
      );

      QueryResult result = await client.mutate(options);

      if (!result.hasException) {
        var data = result.data?['verifyEmail'];
        return CodeConfirmModel.fromJson(data);
      } else {
        return CodeConfirmModel(error: result.exception.toString(), ok: false);
      }
    } catch (e) {
      return CodeConfirmModel(error: e.toString(), ok: false);
    }
  }

  @override
  Future<UserRegistrModel> createAccount({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? password,
    int? gender,
    String? avatar,
    String? bio,
  }) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    try {
      MutationOptions options = MutationOptions(
        document: gql('''
mutation CreateAccount(
    \$firstName: String!,
    \$lastName: String!,
    \$username: String!, 
    \$email: String!, 
    \$password: String!,
    \$gender: Int!, 
    \$avatar: String, 
    \$bio: String,) {
  createAccount(
    firstName: \$firstName, 
    lastName: \$lastName,
    username: \$username, 
    email: \$email, 
    password: \$password,
    gender: \$gender, 
    avatar: \$avatar, 
    bio: \$bio,) {
    ok
    error
    id
  }
}
      '''),
        variables: {
          'firstName': firstName,
          'lastName': lastName,
          'username': username,
          'email': email,
          'password': password,
          'gender': gender,
          'avatar': avatar,
          'bio': bio,
        },
      );

      QueryResult result = await client.mutate(options);

      if (!result.hasException) {
        var data = result.data?['createAccount'];
        return UserRegistrModel.fromJson(data);
      } else {
        return UserRegistrModel(error: result.exception.toString(), ok: false);
      }
    } catch (e) {
      return UserRegistrModel(error: e.toString(), ok: false);
    }
  }

  @override
  Future<UserRegistrModel> login({String? username, String? password}) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    try {
      MutationOptions options = MutationOptions(
        document: gql('''
mutation Login(\$username: String!, \$password: String!) {
  login(username: \$username, password: \$password) {
    ok
    error
    token
  }
}
      '''),
        variables: {
          'username': username,
          'password': password,
        },
      );

      QueryResult result = await client.mutate(options);

      if (!result.hasException) {
        var data = result.data?['login'];
        print(result.data);
        return UserRegistrModel.fromJson(data);
      } else {
        return UserRegistrModel(
            error: result.exception.toString(), ok: false, token: null);
      }
    } catch (e) {
      return UserRegistrModel(error: e.toString(), ok: false, token: null);
    }
  }
}
