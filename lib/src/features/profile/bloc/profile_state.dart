part of "profile_bloc.dart";

class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  ProfileLoaded(this.user);
}

class ProfileError extends ProfileState {
  final String message;
  final UserModel? user;

  ProfileError(this.message, [this.user]);
}

class UserFollowState extends ProfileState {
  final bool isFollowing;

  UserFollowState({this.isFollowing = false});

  UserFollowState copyWith({bool? isFollowing}) {
    return UserFollowState(
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}

class FollowUserFailed extends ProfileState {
  final String message;
  FollowUserFailed(this.message);
}

class FollowUserSuccess extends ProfileState {
  final UserModel updatedUser;
  FollowUserSuccess(this.updatedUser);
}

class UnFollowUserSuccess extends ProfileState {
  final UserModel updatedUser;
  UnFollowUserSuccess(this.updatedUser);
}

class UserFollowStatusChanged extends ProfileState {
  final bool isFollowing;

  UserFollowStatusChanged(this.isFollowing);

  List<Object> get props => [isFollowing];
}

class UnFollowUserFailed extends ProfileState {
  final String message;
  UnFollowUserFailed(this.message);
}

class EditPasswordSuccess extends ProfileState {}

class EditPasswordFailed extends ProfileState {
  final String message;
  EditPasswordFailed(this.message);
}

class EditProfileSuccess extends ProfileState {}

class EditProfileFailed extends ProfileState {
  final String message;
  EditProfileFailed(this.message);
}

class CreateRequestSuccess extends ProfileState {}

class CreateRequestFailed extends ProfileState {
  final String message;
  CreateRequestFailed(this.message);
}

class OfficialRequestSuccess extends ProfileState {}

class OfficialRequestFailed extends ProfileState {
  final String message;

  OfficialRequestFailed(this.message);

  List<Object> get props => [message];
}

class ProfileFollowersLoaded extends ProfileState {
  final List<UserModel> followers;

  ProfileFollowersLoaded(this.followers);

  List<Object> get props => [followers];
}

class ProfileFollowingLoaded extends ProfileState {
  final List<UserModel> following;
  ProfileFollowingLoaded(this.following);

  List<Object> get props => [following];
}

class ToggleLikeState extends ProfileState {
  final UserModel user;

  ToggleLikeState(this.user);
}

class DeletePostFailed extends ProfileState {
  final String message;

  DeletePostFailed(this.message);

  List<Object> get props => [message];
}

class BanUserSuccess extends ProfileState {}

class BanUserFailed extends ProfileState {
  final String message;
  BanUserFailed(this.message);

  List<Object> get props => [message];
}
