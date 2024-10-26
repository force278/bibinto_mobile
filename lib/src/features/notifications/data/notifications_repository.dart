import 'dart:async';

import 'package:bibinto/src/common/widgets/model/error_model.dart';
import 'package:bibinto/src/features/notifications/data/abstract_notifications_repository.dart';
import 'package:bibinto/src/features/notifications/model/notification_model.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:bibinto/src/graphql_config/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class NotificationsRepository implements AbstractNotificationsRepository {
  static GraphQLConfig graphQLConfig = GraphQLConfig();

  @override
  Future<List<NotificationModel>?> seeNotifications() async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final QueryOptions options = QueryOptions(
      document: gql('''
    query seeNotifications {
      seeNotifications {
        likes {
          createdAt
          photo {
            file
            __typename
          }
          id
          user {
            avatar
            username
            __typename
          }
          read
          __typename
        }
        comments {
          createdAt
          photo {
            file
            __typename
          }
          user {
            avatar
            username
            __typename
          }
          payload
          read
          __typename
        }
        subs {
          username
          avatar
          createdAt
          read
          __typename
        }
        __typename
      }
    }
    '''),
    );

    final QueryResult result = await client.query(options);

    if (!result.hasException) {
      var data = result.data?['seeNotifications'];
      if (data == null) {
        return null;
      }
      List<NotificationModel> notifications = [];
      if (data['likes'] != null) {
        notifications.addAll(data['likes'].map<NotificationModel>((likeData) {
          return NotificationModel.fromJson({'like': likeData});
        }).toList());
      }
      if (data['comments'] != null) {
        notifications
            .addAll(data['comments'].map<NotificationModel>((commentData) {
          return NotificationModel.fromJson({'comment': commentData});
        }).toList());
      }
      if (data['subs'] != null) {
        notifications.addAll(data['subs'].map<NotificationModel>((subData) {
          return NotificationModel.fromJson({'sub': subData});
        }).toList());
      }
      return notifications;
    } else {
      // throw Exception(result.exception.toString());
      return [];
    }
  }

  final notificationsSubscriprion = gql(r'''
subscription NotificationsUpdates {
  notificationsUpdates {
     like {
      createdAt
      photo {
        file
        __typename
      }
      id
      user {
        avatar
        username
        __typename
      }
      read
      value
      __typename
    }
      comment {
      createdAt
      photo {
        file
        __typename
      }
      user {
        avatar
        username
        __typename
      }
      payload
      read
      __typename
    }
    sub {
      username
      avatar
      createdAt
      read
      __typename
    }
  }
}
''');

  final StreamController<dynamic> _notificationsController =
      StreamController<dynamic>.broadcast();

  Stream<dynamic> subscribeToNotifications() {
    return _notificationsController.stream;
  }

  void unsubscribeFromNotifications() {
    _notificationsController.close();
  }

  @override
  Future<UserModel?> fetchUserProfile(String username) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final QueryOptions options = QueryOptions(
      document: gql('''
      query seeProfile(\$username: String!) {
  seeProfile(username: \$username) {
    firstName
    lastName
    username
    id
    bio
    avatar
    official
    totalFollowers
    totalFollowing
    photos {
      ...MyPostFragment
      __typename
    }
    isMe
    isFollowing
    __typename
  }
}

fragment MyPostFragment on Photo {
  id
  file
  likes
  isLiked
  createdAt
  updatedAt
  caption
  comments {
    id
    user {
      avatar
      username
      official
      __typename
    }
    payload
    createdAt
    isMine
    __typename
  }
  commentsNumber
  __typename
}
    '''),
      variables: {
        'username': username,
      },
    );

    final QueryResult result = await client.query(options);

    if (!result.hasException) {
      var data = result.data?['seeProfile'];
      if (data == null) {
        return null;
      }
      return UserModel.fromJson(data);
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<ErrorModel> deleteCommentInNotifications(int deleteCommentId) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final MutationOptions options = MutationOptions(
      document: gql('''
mutation DeleteComment(\$deleteCommentId: Int!) {
  deleteComment(id: \$deleteCommentId) {
    ok
    error
    id
  }
}
  '''),
      variables: {
        'deleteCommentId': deleteCommentId,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (!result.hasException) {
      var data = result.data?['deleteComment'];
      if (data == null) {
        return ErrorModel(ok: false, error: 'Data is null');
      }
      return ErrorModel.fromJson(data);
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<bool> toggleLike(int toggleLikeId, int value) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final MutationOptions options = MutationOptions(
      document: gql('''
      mutation ToggleLike(\$toggleLikeId: Int!, \$value: Int!) {
        toggleLike(id: \$toggleLikeId, value: \$value) {
          ok
          error
          id
        }
      }
    '''),
      variables: {
        'toggleLikeId': toggleLikeId,
        'value': value,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (!result.hasException) {
      var data = result.data?['toggleLike'];
      return data?['ok'] ?? false;
    } else {
      throw Exception(result.exception.toString());
    }
  }
}
