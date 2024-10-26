part of 'gallery_bloc.dart';

class GalleryState {}

class GalleryInitial extends GalleryState {}

class RecsLoading extends GalleryState {}

class RecsLoaded extends GalleryState {
  final List<RecModel?> recs;

  RecsLoaded(
    this.recs,
  );
}

class UserProfileLoaded extends GalleryState {
  final UserModel userProfile;

  UserProfileLoaded(this.userProfile);
}

class RecsError extends GalleryState {
  final String message;
  final List<RecModel?>? recs;

  RecsError(this.message, [this.recs]);
}

class CommentCreatedSuccess extends GalleryState {}

class CommentCreationFailed extends GalleryState {
  final String message;
  CommentCreationFailed(this.message);
}

class LikeToggled extends GalleryState {
  final bool isLiked;

  LikeToggled(this.isLiked);

  List<Object> get props => [isLiked];
}

class LikeToggledError extends GalleryState {
  final String message;
  LikeToggledError(this.message);
}

class ReportPhotoSuccess extends GalleryState {}

class ReportPhotoFailed extends GalleryState {
  final String message;
  ReportPhotoFailed(this.message);
}

class UserFollowState extends GalleryState {
  final bool isFollowing;

  UserFollowState({this.isFollowing = false});

  UserFollowState copyWith({bool? isFollowing}) {
    return UserFollowState(
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}

class FollowUserFailed extends GalleryState {
  final String message;
  FollowUserFailed(this.message);
}

class FollowUserSuccess extends GalleryState {
  final UserModel updatedUser;
  FollowUserSuccess(this.updatedUser);
}

class UnFollowUserSuccess extends GalleryState {
  final UserModel updatedUser;
  UnFollowUserSuccess(this.updatedUser);
}

class UserFollowStatusChanged extends GalleryState {
  final bool isFollowing;

  UserFollowStatusChanged(this.isFollowing);

  List<Object> get props => [isFollowing];
}

class UnFollowUserFailed extends GalleryState {
  final String message;
  UnFollowUserFailed(this.message);
}

class FollowersLoaded extends GalleryState {
  final List<UserModel> followers;
  FollowersLoaded(this.followers);

  List<Object> get props => [followers];
}

class UserProfileFollowingLoaded extends GalleryState {
  final List<UserModel> following;

  UserProfileFollowingLoaded(this.following);

  List<Object> get props => [following];
}

class DeletePhotoFailed extends GalleryState {
  final String message;
  DeletePhotoFailed(this.message);
}

class BanUserSuccess extends GalleryState {}

class BanUserFailed extends GalleryState {
  final String message;
  BanUserFailed(this.message);

  List<Object> get props => [message];
}

class RecLoaded extends GalleryState {
  final RecModel rec;

  RecLoaded(this.rec);

  List<Object> get props => [rec];
}
