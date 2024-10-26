import 'package:bibinto/src/features/chats/data/abstract_chats_repository.dart';
import 'package:bibinto/src/features/chats/model/dialog_model.dart';
import 'package:bibinto/src/graphql_config/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ChatsRepository implements AbstractChatsRepository {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  @override
  Future<List<DialogModel>?> seeDialogs() async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final QueryOptions options = QueryOptions(
      document: gql('''
      query seeDialogs {
        seeDialogs {
          id
          messages {
            id
            createdAt
            payload
            read
            user {
              username
              isMe
              __typename
            }
            __typename
          }
          unreadTotal
          users {
            username
            avatar
            isMe
            id
            __typename
          }
          __typename
          createdAt
          updatedAt
        }
      }
    '''),
    );

    final QueryResult result = await client.query(options);

    if (!result.hasException) {
      var data = result.data?['seeDialogs'];
      if (data == null) {
        return null;
      }
      return data
          .map<DialogModel>((dialog) => DialogModel.fromJson(dialog))
          .toList();
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<DialogModel?> seeDialog(int userId, int? seeDialogId) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final QueryOptions options = QueryOptions(
      document: gql('''
    query SeeDialog(\$userId: Int!, \$seeDialogId: Int) {
      seeDialog(userId: \$userId, id: \$seeDialogId) {
        id
        messages {
          id
          createdAt
          payload
          read
          user {
            username
            isMe
            __typename
          }
          __typename
        }
        users {
          username
          avatar
          isMe
          id
          __typename
        }
        unreadTotal
        createdAt
        updatedAt
      }
    }
    '''),
      variables: {
        'userId': userId,
        'seeDialogId': seeDialogId,
      },
    );

    final QueryResult result = await client.query(options);

    if (!result.hasException) {
      var data = result.data?['seeDialog'];
      if (data == null) {
        return null;
      }
      return DialogModel.fromJson(data);
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<bool> readDialog(int readDialogId) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final MutationOptions options = MutationOptions(
      document: gql('''
      mutation ReadDialog(\$readDialogId: Int!) {
        readDialog(id: \$readDialogId) {
          ok
          error
          id
        }
      }
    '''),
      variables: {
        'readDialogId': readDialogId,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (!result.hasException) {
      var data = result.data?['readDialog'];
      if (data != null && data['ok'] == true) {
        return true;
      } else {
        throw Exception('Failed to read dialog: ${data['error']}');
      }
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<bool> sendMessage(String payload, int userId) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final MutationOptions options = MutationOptions(
      document: gql('''
    mutation SendMessage(\$payload: String!, \$userId: Int!) {
      sendMessage(payload: \$payload, userId: \$userId) {
        ok
        error
        id
      }
    }
    '''),
      variables: {
        'payload': payload,
        'userId': userId,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (!result.hasException) {
      var data = result.data?['sendMessage'];
      if (data != null && data['ok'] == true) {
        return true;
      } else {
        throw Exception('Failed to send message: ${data['error']}');
      }
    } else {
      throw Exception(result.exception.toString());
    }
  }
}
