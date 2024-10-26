import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/features/gallery/model/comments_model.dart';
import 'package:bibinto/src/features/notifications/data/notifications_repository.dart';
import 'package:bibinto/src/features/notifications/model/like_model.dart';
import 'package:bibinto/src/features/notifications/model/notification_model.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class NotificationLayout extends StatefulWidget {
  const NotificationLayout({
    super.key,
    required this.notifications,
  });

  final List<NotificationModel> notifications;

  @override
  State<NotificationLayout> createState() => _NotificationLayoutState();
}

class _NotificationLayoutState extends State<NotificationLayout> {
  final NotificationsRepository _notificationsRepository =
      NotificationsRepository();

  @override
  void initState() {
    super.initState();
    _subscribeToNotifications();
  }

  void _subscribeToNotifications() {
    _notificationsRepository
        .subscribeToNotifications()
        .listen((notificationJson) {
      _addNotification(notificationJson);
    });
  }

  @override
  void dispose() {
    _notificationsRepository.unsubscribeFromNotifications();
    super.dispose();
  }

  void _addNotification(Map<String, dynamic> notificationJson) {
    if (notificationJson['like'] != null) {
      var notification = NotificationModel.fromJson({
        'like': notificationJson['like'],
        'createdAt': DateTime.parse(notificationJson['like']['createdAt'])
      });
      _addToList(notification);
    }
    if (notificationJson['comment'] != null) {
      var notification = NotificationModel.fromJson({
        'comment': notificationJson['comment'],
        'createdAt': DateTime.parse(notificationJson['comment']['createdAt'])
      });
      _addToList(notification);
    }
    if (notificationJson['sub'] != null) {
      var notification = NotificationModel.fromJson({
        'sub': notificationJson['sub'],
        'createdAt': DateTime.parse(notificationJson['sub']['createdAt'])
      });
      _addToList(notification);
    }
  }

  void _addToList(NotificationModel notification) {
    var uniqueKey =
        '${notification.like?.id ?? ""}_${notification.comment?.id ?? ""}_${notification.sub?.id ?? ""}';

    bool alreadyExists = widget.notifications.any((existingNotification) {
      var existingKey =
          '${existingNotification.like?.id ?? ""}_${existingNotification.comment?.id ?? ""}_${existingNotification.sub?.id ?? ""}';
      return existingKey == uniqueKey;
    });

    if (!alreadyExists) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          widget.notifications.add(notification);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Subscription(
        options: SubscriptionOptions(
          document: _notificationsRepository.notificationsSubscriprion,
        ),
        builder: (QueryResult<Object?> result) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return ListNotifications(notificationsList: widget.notifications);
          }

          var notificationsJson = {
            'like': result.data?['notificationsUpdates']?['like'],
            'comment': result.data?['notificationsUpdates']?['comment'],
            'sub': result.data?['notificationsUpdates']?['sub']
          };
          if (notificationsJson.isNotEmpty) {
            _addNotification(notificationsJson);
          }
          return ListNotifications(notificationsList: widget.notifications);
        },
      ),
    );
  }
}

class ListNotifications extends StatelessWidget {
  const ListNotifications({
    super.key,
    required this.notificationsList,
  });

  final List<NotificationModel> notificationsList;

  @override
  Widget build(BuildContext context) {
    notificationsList.sort((a, b) {
      var dateA = a.like?.createdAt ?? a.comment?.createdAt ?? a.sub?.createdAt;
      var dateB = b.like?.createdAt ?? b.comment?.createdAt ?? b.sub?.createdAt;
      return DateTime.parse(dateB!).compareTo(DateTime.parse(dateA!));
    });
    int unreadCount = notificationsList
        .where((notification) => (notification.like?.read == false ||
            notification.comment?.read == false ||
            notification.sub?.read == false))
        .length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                unreadCount == 0
                    ? Localized.of(context).newCommentisEmpty
                    : Localized.of(context).newNotifications(unreadCount),
                style: const TextStyle(
                  fontFamily: 'Golos Text',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color.fromRGBO(118, 118, 140, 1),
                ),
              ),
            ),
            unreadCount == 0
                ? const SizedBox()
                : Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: notificationsList.length,
                        itemBuilder: (context, index) {
                          final notification = notificationsList[index];
                          return (notification.sub != null &&
                                      notification.sub?.read == false) ||
                                  (notification.comment != null &&
                                      notification.comment?.read == false) ||
                                  (notification.like != null &&
                                      notification.like?.read == false)
                              ? Column(
                                  children: [
                                    const SizedBox(height: 16),
                                    if (notification.sub != null &&
                                        notification.sub?.read == false)
                                      _buildSubNotification(
                                          notification.sub, context),
                                    if (notification.comment != null &&
                                        notification.comment?.read == false)
                                      _buildCommentNotification(
                                          notification.comment, context),
                                    if (notification.like != null &&
                                        notification.like?.read == false)
                                      _buildLikeNotification(
                                          notification.like, context),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                      const Divider(
                        height: 1,
                        color: Color.fromRGBO(242, 242, 247, 1),
                      ),
                    ],
                  ),
            const SizedBox(
              height: 12,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                notificationsList.isEmpty
                    ? Localized.of(context).notViewed
                    : Localized.of(context).viewed,
                style: const TextStyle(
                  fontFamily: 'Golos Text',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color.fromRGBO(118, 118, 140, 1),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notificationsList.length,
              itemBuilder: (context, index) {
                final notification = notificationsList[index];
                return (notification.sub != null &&
                            notification.sub?.read == true) ||
                        (notification.comment != null &&
                            notification.comment?.read == true) ||
                        (notification.like != null &&
                            notification.like?.read == true)
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          if (notification.sub != null &&
                              notification.sub?.read == true) ...[
                            _buildSubNotification(notification.sub, context),
                          ],
                          if (notification.comment != null &&
                              notification.comment?.read == true) ...[
                            _buildCommentNotification(
                                notification.comment, context),
                          ],
                          if (notification.like != null &&
                              notification.like?.read == true) ...[
                            _buildLikeNotification(notification.like, context),
                          ],
                        ],
                      )
                    : const SizedBox.shrink();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(height: 1, color: Color.fromRGBO(242, 242, 247, 1))
          ],
        ),
      ),
    );
  }
}

Widget _buildLikeNotification(LikeModel? notification, BuildContext context) {
  return InkWell(
    onTap: () {
      AutoRouter.of(context).push(
        UserProfileInNotificationsRoute(
            username: notification?.user.username ?? ''),
      );
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipOval(
              child: notification?.user.avatar != null
                  ? Image.network(
                      notification?.user.avatar ?? '',
                      height: 50,
                      width: 50,
                    )
                  : const Icon(
                      Icons.person,
                      size: 50,
                      color: Color.fromRGBO(174, 174, 178, 1),
                    ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification?.user.username ?? '',
                  style: const TextStyle(
                    fontFamily: 'Golos Text',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Color.fromRGBO(31, 31, 44, 1),
                  ),
                ),
                Text(
                  Localized.of(context).likedYourPost,
                  style: const TextStyle(
                    fontFamily: 'Golos Text',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Color.fromRGBO(118, 118, 140, 1),
                  ),
                )
              ],
            )
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            notification?.photo?.file ?? '',
            height: 50,
            width: 50,
          ),
        )
      ],
    ),
  );
}

Widget _buildCommentNotification(
    CommentsModel? notification, BuildContext context) {
  return InkWell(
    onTap: () {
      AutoRouter.of(context).push(
        UserProfileInNotificationsRoute(
            username: notification?.user?.username ?? ''),
      );
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipOval(
              child: notification?.user?.avatar != null
                  ? Image.network(
                      notification?.user?.avatar ?? '',
                      height: 50,
                      width: 50,
                    )
                  : const Icon(
                      Icons.person,
                      size: 50,
                      color: Color.fromRGBO(174, 174, 178, 1),
                    ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification?.user?.username ?? '',
                  style: const TextStyle(
                    fontFamily: 'Golos Text',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Color.fromRGBO(31, 31, 44, 1),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 200),
                  child: Text(
                    Localized.of(context)
                        .commented(notification?.payload ?? ''),
                    style: const TextStyle(
                      fontFamily: 'Golos Text',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color.fromRGBO(118, 118, 140, 1),
                    ),
                    softWrap: true,
                  ),
                )
              ],
            )
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            notification?.photo?.file ?? '',
            height: 50,
            width: 50,
          ),
        )
      ],
    ),
  );
}

Widget _buildSubNotification(UserModel? notification, BuildContext context) {
  return InkWell(
    onTap: () {
      AutoRouter.of(context).push(
        UserProfileInNotificationsRoute(username: notification?.username ?? ''),
      );
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipOval(
              child: notification?.avatar != null
                  ? Image.network(
                      notification?.avatar ?? '',
                      height: 50,
                      width: 50,
                    )
                  : const Icon(
                      Icons.person,
                      size: 50,
                      color: Color.fromRGBO(174, 174, 178, 1),
                    ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 100),
                  child: Text(
                    notification?.username ?? '',
                    style: const TextStyle(
                      fontFamily: 'Golos Text',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Color.fromRGBO(31, 31, 44, 1),
                    ),
                    softWrap: true,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 100),
                  child: Text(
                    Localized.of(context).subscribeToYou,
                    style: const TextStyle(
                      fontFamily: 'Golos Text',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color.fromRGBO(118, 118, 140, 1),
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    ),
  );
}
