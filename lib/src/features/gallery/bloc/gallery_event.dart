part of 'gallery_bloc.dart';

abstract class GalleryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRecs extends GalleryEvent {}

class FetchFeed extends GalleryEvent {
  final int offset;

  FetchFeed(this.offset);
}

class CreateCommentEvent extends GalleryEvent {
  final int photoId;
  final String payload;

  CreateCommentEvent(this.photoId, this.payload);

  @override
  List<Object> get props => [photoId, payload];
}

class ToggleLike extends GalleryEvent {
  final int toggleLikeId;
  final int value;

  ToggleLike(this.toggleLikeId, this.value);

  @override
  List<Object> get props => [toggleLikeId, value];
}

class ToggleLikeProfile extends GalleryEvent {
  final int toggleLikeId;
  final int value;

  ToggleLikeProfile(this.toggleLikeId, this.value);

  @override
  List<Object> get props => [toggleLikeId, value];
}

class ReportPhotoEvent extends GalleryEvent {
  final int photoId;
  final String? reportText;

  ReportPhotoEvent(this.photoId, this.reportText);

  @override
  List<Object?> get props => [photoId, reportText];
}

class FollowUser extends GalleryEvent {
  final String username;

  FollowUser(this.username);

  @override
  List<Object> get props => [username];
}

class UnFollowUser extends GalleryEvent {
  final String username;

  UnFollowUser(
    this.username,
  );

  @override
  List<Object> get props => [username];
}

class GetFollowers extends GalleryEvent {
  final String username;
  final int page;

  GetFollowers(this.username, this.page);
}

class UserFetchFollowing extends GalleryEvent {
  final String username;
  final int lastId;

  UserFetchFollowing(this.username, this.lastId);

  @override
  List<Object> get props => [username, lastId];
}

class DeletePhoto extends GalleryEvent {
  final int deletePhotoId;

  DeletePhoto(
    this.deletePhotoId,
  );

  @override
  List<Object> get props => [deletePhotoId];
}

class BanUserEvent extends GalleryEvent {
  final int banUserId;

  BanUserEvent(this.banUserId);

  @override
  List<Object> get props => [banUserId];
}

class FetchUser extends GalleryEvent {
  final String username;

  FetchUser(this.username);
}

class GetRec extends GalleryEvent {}

class DeleteCommentInGallery extends GalleryEvent {
  final int deleteCommentId;

  DeleteCommentInGallery(this.deleteCommentId);

  List<Object> get props => [deleteCommentId];
}
