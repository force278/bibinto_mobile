part of 'notifications_bloc.dart';

class NotificationsEvent {}

class FetchNotificationsEvent extends NotificationsEvent {}

class FetchUserProfileInNotifications extends NotificationsEvent {
  final String username;

  FetchUserProfileInNotifications(this.username);
}

class DeleteCommentInNotifications extends NotificationsEvent {
  final int deleteCommentId;

  DeleteCommentInNotifications(this.deleteCommentId);

  List<Object> get props => [deleteCommentId];
}

class ToggleLikeInNotifications extends NotificationsEvent {
  final int toggleLikeId;
  final int value;

  ToggleLikeInNotifications(this.toggleLikeId, this.value);

  List<Object> get props => [toggleLikeId, value];
}
