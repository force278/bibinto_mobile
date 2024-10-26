import 'package:bibinto/src/common/widgets/model/error_model.dart';
import 'package:bibinto/src/features/gallery/data/abstract_gallery_rpository.dart';
import 'package:bibinto/src/features/gallery/model/rec_model.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'gallery_state.dart';
part 'gallery_event.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc(AbstractGalleryRepository galleryRepository)
      : super(GalleryInitial()) {
    on<FetchRecs>((event, emit) async {
      emit(RecsLoading());
      try {
        final recs = await galleryRepository.fetchRecs();
        emit(RecsLoaded(recs));
      } catch (e) {
        emit(RecsError(e.toString()));
        print(e.toString());
      }
    });

    on<FetchFeed>((event, emit) async {
      try {
        final feed = await galleryRepository.fetchFeed(event.offset);
        if (state is RecsLoaded) {
          final currentState = state as RecsLoaded;
          final updatedRecs = currentState.recs + feed;
          emit(RecsLoaded(updatedRecs));
        } else {
          emit(RecsLoaded(feed));
        }
      } catch (e) {
        emit(RecsError(e.toString()));
      }
    });

    on<CreateCommentEvent>((event, emit) async {
      try {
        final bool result =
            await galleryRepository.createComment(event.photoId, event.payload);
        if (result) {
          emit(CommentCreatedSuccess());
        } else {
          emit(CommentCreationFailed("Не удалось создать комментарий."));
        }
      } catch (e) {
        emit(CommentCreationFailed(e.toString()));
      }
    });

    on<ToggleLike>((event, emit) async {
      try {
        await galleryRepository.toggleLike(event.toggleLikeId, event.value);
        if (state is RecsLoaded) {
          final currentState = state as RecsLoaded;
          final updatedRecs = currentState.recs.map((rec) {
            if (rec?.id == event.toggleLikeId) {
              bool isLiked = rec!.isLiked;
              bool isDisliked = rec.isDisliked;

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

              final likes = isLiked ? rec.likes + 1 : rec.likes - 1;

              return rec.copyWith(
                isLiked: isLiked,
                isDisliked: isDisliked,
                likes: likes,
              );
            }
            return rec;
          }).toList();
          emit(RecsLoaded(updatedRecs));
        }
      } catch (e) {
        emit(LikeToggledError(e.toString()));
      }
    });

    on<ToggleLikeProfile>((event, emit) async {
      try {
        await galleryRepository.toggleLike(event.toggleLikeId, event.value);
        if (state is UserProfileLoaded) {
          final currentState = state as UserProfileLoaded;
          final updatedRecs = currentState.userProfile.photos?.map((rec) {
            if (rec.id == event.toggleLikeId) {
              bool isLiked = rec.isLiked ?? false;
              bool isDisliked = rec.isDisliked ?? false;

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
                  isLiked ? (rec.likes ?? 0) + 1 : (rec.likes ?? 0) - 1;

              return rec.copyWith(
                isLiked: isLiked,
                isDisliked: isDisliked,
                likes: likes,
              );
            }
            return rec;
          }).toList();
          final updatedPhoto =
              currentState.userProfile.copyWith(photos: updatedRecs);
          emit(UserProfileLoaded(updatedPhoto));
        }
      } catch (e) {
        emit(LikeToggledError(e.toString()));
      }
    });

    on<ReportPhotoEvent>((event, emit) async {
      try {
        final bool result = await galleryRepository.reportPhoto(
            event.photoId, event.reportText);
        if (result) {
          emit(ReportPhotoSuccess());
        } else {
          emit(ReportPhotoFailed("Не удалось сообщить о фотографии."));
        }
      } catch (e) {
        emit(ReportPhotoFailed(e.toString()));
      }
    });

    on<FollowUser>((event, emit) async {
      try {
        final bool result = await galleryRepository.followUser(event.username);
        if (result) {
          if (state is RecsLoaded) {
            final currentState = state as RecsLoaded;
            final updatedRecs = currentState.recs.map((rec) {
              if (rec?.user.username == event.username) {
                final updatedUser = rec!.user.copyWith(isFollowing: true);
                return rec.copyWith(user: updatedUser);
              }
              return rec;
            }).toList();
            emit(
              RecsLoaded(updatedRecs),
            );
          }
        } else {
          emit(FollowUserFailed("Не удалось подписаться на пользователя."));
        }
      } catch (e) {
        emit(FollowUserFailed(e.toString()));
      }
    });

    on<UnFollowUser>((event, emit) async {
      try {
        final bool result =
            await galleryRepository.unFollowUser(event.username);
        if (result) {
          if (state is RecsLoaded) {
            final currentState = state as RecsLoaded;
            final updatedRecs = currentState.recs.map((rec) {
              if (rec?.user.username == event.username) {
                final updatedUser = rec!.user.copyWith(isFollowing: false);
                return rec.copyWith(user: updatedUser);
              }
              return rec;
            }).toList();
            emit(
              RecsLoaded(updatedRecs),
            );
          }
        } else {
          emit(UnFollowUserFailed("Не удалось отписаться от пользователя."));
        }
      } catch (e) {
        emit(UnFollowUserFailed(e.toString()));
      }
    });

    on<GetFollowers>((event, emit) async {
      emit(RecsLoading());
      try {
        final allFollowers = <UserModel>[];
        int currentPage = event.page;
        int totalPages;
        do {
          final followersResponse =
              await galleryRepository.seeFollowers(event.username, currentPage);
          allFollowers.addAll(followersResponse.followers);
          totalPages = followersResponse.totalPages;
          currentPage++;
        } while (currentPage <= totalPages);

        emit(FollowersLoaded(allFollowers));
      } catch (e) {
        emit(RecsError(e.toString()));
      }
    });

    on<UserFetchFollowing>((event, emit) async {
      try {
        final following = await galleryRepository.seeUserFollowing(
            event.username, event.lastId);
        if (state is UserProfileFollowingLoaded) {
          final currentState = state as UserProfileFollowingLoaded;
          emit(UserProfileFollowingLoaded(currentState.following + following));
        } else {
          emit(UserProfileFollowingLoaded(following));
        }
      } catch (e) {
        emit(RecsError(e.toString()));
      }
    });

    on<DeletePhoto>((event, emit) async {
      try {
        final bool result =
            await galleryRepository.deletePhoto(event.deletePhotoId);
        if (result) {
          if (state is RecsLoaded) {
            final currentState = state as RecsLoaded;
            final updatedRecs = currentState.recs
                .where((rec) => rec?.id != event.deletePhotoId)
                .toList();
            emit(RecsLoaded(updatedRecs));
          }
        } else {
          emit(DeletePhotoFailed("Не удалось удалить фотографию."));
        }
      } catch (e) {
        emit(DeletePhotoFailed(e.toString()));
      }
    });

    on<BanUserEvent>((event, emit) async {
      try {
        final ErrorModel result =
            await galleryRepository.banUser(event.banUserId);
        if (result.ok) {
          emit(BanUserSuccess());
        } else {
          emit(RecsError(result.error ?? ''));
        }
      } catch (e) {
        emit(RecsError(e.toString()));
      }
    });

    on<FetchUser>((event, emit) async {
      emit(RecsLoading());
      try {
        final userProfile =
            await galleryRepository.fetchUserProfile(event.username);
        if (userProfile != null) {
          emit(UserProfileLoaded(userProfile));
        } else {
          emit(RecsError("Profile not found"));
        }
      } catch (e) {
        emit(RecsError(e.toString()));
      }
    });

    on<GetRec>((event, emit) async {
      try {
        RecModel? rec;
        bool isDuplicate;

        do {
          rec = await galleryRepository.getRec();
          if (rec != null && state is RecsLoaded) {
            final currentState = state as RecsLoaded;
            isDuplicate = currentState.recs
                .any((existingRec) => existingRec?.id == rec?.id);
            if (isDuplicate) {}
          } else {
            isDuplicate = false;
          }
        } while (rec != null && isDuplicate);

        if (rec != null) {
          if (state is RecsLoaded) {
            final currentState = state as RecsLoaded;
            final updatedRecs = [rec, ...currentState.recs];
            emit(RecsLoaded(updatedRecs));
          } else {
            emit(RecsLoaded([rec]));
          }
        } else {
          emit(RecsError("Нет новых рекомендаций"));
        }
      } catch (e) {
        emit(RecsError(e.toString()));
      }
    });

    on<DeleteCommentInGallery>((event, emit) async {
      try {
        final ErrorModel result = await galleryRepository
            .deleteCommentInGallery(event.deleteCommentId);
        if (result.ok) {
          if (state is RecsLoaded) {
            final currentState = state as RecsLoaded;
            final updatedRecs = currentState.recs.map((rec) {
              final updatedComments = rec?.comments
                  ?.where((comment) => comment?.id != event.deleteCommentId)
                  .toList();
              return rec?.copyWith(comments: updatedComments);
            }).toList();
            emit(RecsLoaded(updatedRecs));
          }
        } else {
          emit(RecsError(result.error ?? ''));
        }
      } catch (e) {
        emit(RecsError(e.toString()));
      }
    });
  }
}
