part of "profile_bloc.dart";

class ProfileEvent {}

class IsMe extends ProfileEvent {}

class FetchUserProfile extends ProfileEvent {
  final String username;

  FetchUserProfile(this.username);
}

class FollowUserEvent extends ProfileEvent {
  final String username;

  FollowUserEvent(this.username);

  List<Object> get props => [username];
}

class UnFollowUserEvent extends ProfileEvent {
  final String username;

  UnFollowUserEvent(
    this.username,
  );

  List<Object> get props => [username];
}

class EditPasswordEvent extends ProfileEvent {
  final String oldPassword;
  final String newPassword;

  EditPasswordEvent(this.oldPassword, this.newPassword);
}

class EditProfileEvent extends ProfileEvent {
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? bio;

  EditProfileEvent({this.firstName, this.lastName, this.username, this.bio});
}

class CreateRequestEvent extends ProfileEvent {
  final String payload;

  CreateRequestEvent(this.payload);

  List<Object> get props => [payload];
}

class OfficialRequestEvent extends ProfileEvent {
  final String file;

  OfficialRequestEvent(this.file);

  List<Object> get props => [file];
}

class FetchFollowers extends ProfileEvent {
  final String username;
  final int page;

  FetchFollowers(this.username, this.page);
}

class FetchFollowing extends ProfileEvent {
  final String username;
  final int lastId;

  FetchFollowing(this.username, this.lastId);
}

class ToggleLikeEvent extends ProfileEvent {
  final int toggleLikeId;
  final int value;

  ToggleLikeEvent(this.toggleLikeId, this.value);
}

class DeletePost extends ProfileEvent {
  final int deletePhotoId;

  DeletePost(
    this.deletePhotoId,
  );

  List<Object> get props => [deletePhotoId];
}

class BanUser extends ProfileEvent {
  final int banUserId;

  BanUser(this.banUserId);

  List<Object> get props => [banUserId];
}

class DeleteCommentInProfile extends ProfileEvent {
  final int deleteCommentId;

  DeleteCommentInProfile(this.deleteCommentId);

  List<Object> get props => [deleteCommentId];
}
