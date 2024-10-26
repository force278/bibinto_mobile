import 'package:bibinto/src/common/domain/local_storage.dart';
import 'package:bibinto/src/common/widgets/model/error_model.dart';
import 'package:bibinto/src/features/profile/data/repository/abstract_profile_repositoru.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "profile_state.dart";
part "profile_event.dart";

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(AbstractProfileRepository profileRepository)
      : super(ProfileInitial()) {
    on<IsMe>((event, emit) async {
      LocalStorage localStorage = LocalStorage();
      emit(ProfileLoading());
      try {
        final user = await profileRepository.isMe();
        if (user != null) {
          emit(ProfileLoaded(user));
          add(FetchUserProfile(user.username));
          await localStorage.write('username', user.username);
          await localStorage.write('avatar', user.avatar ?? '');
        } else {
          emit(ProfileError("User not found"));
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<FetchUserProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final userProfile =
            await profileRepository.fetchUserProfile(event.username);
        if (userProfile != null) {
          emit(ProfileLoaded(userProfile));
        } else {
          emit(ProfileError("Profile not found"));
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<FollowUserEvent>((event, emit) async {
      try {
        final bool result = await profileRepository.followUser(event.username);
        if (result) {
          if (state is ProfileLoaded) {
            final currentState = state as ProfileLoaded;
            final updatedUser = currentState.user.copyWith(
              isFollowing: true,
              totalFollowers: currentState.user.totalFollowers != null
                  ? currentState.user.totalFollowers! + 1
                  : 0,
            );
            emit(ProfileLoaded(updatedUser));
          }
        } else {
          emit(FollowUserFailed("Не удалось подписаться на пользователя."));
        }
      } catch (e) {
        emit(FollowUserFailed(e.toString()));
      }
    });

    on<UnFollowUserEvent>((event, emit) async {
      try {
        final bool result =
            await profileRepository.unFollowUser(event.username);
        if (result) {
          if (state is ProfileLoaded) {
            final currentState = state as ProfileLoaded;
            final updatedUser = currentState.user.copyWith(
              isFollowing: false,
              totalFollowers: currentState.user.totalFollowers != null
                  ? currentState.user.totalFollowers! - 1
                  : 0,
            );
            emit(ProfileLoaded(updatedUser));
          }
        } else {
          emit(UnFollowUserFailed("Не удалось отписаться от пользователя."));
        }
      } catch (e) {
        emit(UnFollowUserFailed(e.toString()));
      }
    });

    on<EditPasswordEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final bool result = await profileRepository.editPassword(
            event.oldPassword, event.newPassword);
        if (result) {
          emit(EditPasswordSuccess());
        } else {
          emit(EditPasswordFailed("Не удалось изменить пароль."));
        }
      } catch (e) {
        emit(EditPasswordFailed(e.toString()));
      }
    });

    on<EditProfileEvent>((event, emit) async {
      emit(
        ProfileLoading(),
      );
      try {
        final bool result = await profileRepository.editProfile(
          firstName: event.firstName,
          lastName: event.lastName,
          username: event.username,
          bio: event.bio,
        );
        if (result) {
          emit(
            EditProfileSuccess(),
          );
          if (event.username != null) {
            add(
              FetchUserProfile(event.username!),
            );
          }
        } else {
          emit(EditProfileFailed("Не удалось обновить профиль."));
        }
      } catch (e) {
        emit(
          EditProfileFailed(
            e.toString(),
          ),
        );
      }
    });

    on<CreateRequestEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final bool result =
            await profileRepository.createRequest(event.payload);
        if (result) {
          emit(CreateRequestSuccess());
        } else {
          emit(
            CreateRequestFailed("Не удалось создать запрос."),
          );
        }
      } catch (e) {
        emit(CreateRequestFailed(e.toString()));
      }
    });

    on<OfficialRequestEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final bool result = await profileRepository.officialRequest(event.file);
        if (result) {
          emit(
            OfficialRequestSuccess(),
          );
        } else {
          emit(
            OfficialRequestFailed("Не удалось выполнить официальный запрос."),
          );
        }
      } catch (e) {
        emit(OfficialRequestFailed(e.toString()));
      }
    });

    on<FetchFollowers>((event, emit) async {
      try {
        final allFollowers = <UserModel>[];
        int currentPage = event.page;
        int totalPages;

        do {
          final followersResponse =
              await profileRepository.seeFollowers(event.username, currentPage);
          allFollowers.addAll(followersResponse.followers);
          totalPages = followersResponse.totalPages;
          currentPage++;
        } while (currentPage <= totalPages);

        emit(ProfileFollowersLoaded(allFollowers));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<FetchFollowing>((event, emit) async {
      try {
        final following =
            await profileRepository.seeFollowing(event.username, event.lastId);
        if (state is ProfileFollowingLoaded) {
          final currentState = state as ProfileFollowingLoaded;
          emit(ProfileFollowingLoaded(currentState.following + following));
        } else {
          emit(ProfileFollowingLoaded(following));
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<ToggleLikeEvent>((event, emit) async {
      try {
        await profileRepository.toggleLike(event.toggleLikeId, event.value);
        if (state is ProfileLoaded) {
          final currentState = state as ProfileLoaded;
          final updatedPost = currentState.user.photos?.map(
            (post) {
              if (post.id == event.toggleLikeId) {
                bool isLiked = post.isLiked ?? false;
                bool isDisliked = post.isDisliked ?? false;
                if (event.value == 10) {
                  isLiked = !isLiked;
                  isDisliked = false;
                } else if (event.value == 1) {
                  isDisliked = !isDisliked;
                  isLiked = false;
                } else {
                  isDisliked = false;
                  isLiked = false;
                }

                final likes =
                    isLiked ? (post.likes ?? 0) + 1 : (post.likes ?? 0) - 1;
                return post.copyWith(
                  isLiked: isLiked,
                  isDisliked: isDisliked,
                  likes: likes,
                );
              }
              return post;
            },
          ).toList();
          final updatedUser = currentState.user.copyWith(photos: updatedPost);
          emit(ProfileLoaded(updatedUser));
        }
      } catch (e) {
        emit(
          ProfileError(
            e.toString(),
          ),
        );
      }
    });

    on<DeletePost>((event, emit) async {
      try {
        final bool result =
            await profileRepository.deletePhoto(event.deletePhotoId);
        if (result) {
          if (state is ProfileLoaded) {
            final currentState = state as ProfileLoaded;
            final updatedPhotos = currentState.user.photos
                ?.where((photo) => photo.id != event.deletePhotoId)
                .toList();
            emit(ProfileLoaded(
                currentState.user.copyWith(photos: updatedPhotos)));
          }
        } else {
          emit(DeletePostFailed("Не удалось удалить фотографию."));
        }
      } catch (e) {
        emit(DeletePostFailed(e.toString()));
      }
    });

    on<BanUser>((event, emit) async {
      try {
        final ErrorModel result =
            await profileRepository.banUser(event.banUserId);
        if (result.ok) {
          emit(BanUserSuccess());
        } else {
          emit(ProfileError(result.error ?? ''));
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<DeleteCommentInProfile>((event, emit) async {
      try {
        final ErrorModel result = await profileRepository
            .deleteCommentInProfile(event.deleteCommentId);
        if (result.ok) {
          if (state is ProfileLoaded) {
            final currentState = state as ProfileLoaded;
            final updatedPhotos = currentState.user.photos?.map((photo) {
              final updatedComments = photo.comments
                  ?.where((comment) => comment?.id != event.deleteCommentId)
                  .toList();
              return photo.copyWith(comments: updatedComments);
            }).toList();
            final updatedUser =
                currentState.user.copyWith(photos: updatedPhotos);
            emit(ProfileLoaded(updatedUser));
          }
        } else {
          emit(ProfileError(result.error ?? ''));
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
