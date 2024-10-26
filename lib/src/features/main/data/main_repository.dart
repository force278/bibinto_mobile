import 'package:bibinto/src/features/main/data/main_abstract_repository.dart';
import 'package:bibinto/src/features/notifications/model/notification_model.dart';
import 'package:bibinto/src/graphql_config/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MainRepository implements AbstractMainRepository {
  static GraphQLConfig graphQLConfig = GraphQLConfig();

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
      return [];
    }
  }
}
