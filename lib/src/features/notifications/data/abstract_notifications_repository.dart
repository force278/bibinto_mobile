import 'package:bibinto/src/common/widgets/model/error_model.dart';
import 'package:bibinto/src/features/notifications/model/notification_model.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';

abstract interface class AbstractNotificationsRepository {
  Future<List<NotificationModel>?> seeNotifications();

  Future<UserModel?> fetchUserProfile(String username);

  Future<ErrorModel> deleteCommentInNotifications(int deleteCommentId);

  Future<bool> toggleLike(int toggleLikeId, int value);
}
