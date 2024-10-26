import 'package:bibinto/src/features/notifications/model/notification_model.dart';

abstract interface class AbstractMainRepository {
  Future<List<NotificationModel>?> seeNotifications();
}
