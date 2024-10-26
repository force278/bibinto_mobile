part of 'notifications_bloc.dart';

class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationModel>? notifications;
  final UserModel? user;

  NotificationsLoaded({this.notifications, this.user});
}

class NotificationsEmpty extends NotificationsState {}

class NotificationsFailure extends NotificationsState {
  final String message;
  NotificationsFailure(this.message);
}

class UserProfileLoadedInNotification extends NotificationsState {
  final UserModel user;
  UserProfileLoadedInNotification(this.user);
}
