import 'package:bibinto/src/common/widgets/model/error_model.dart';
import 'package:bibinto/src/features/notifications/data/abstract_notifications_repository.dart';
import 'package:bibinto/src/features/notifications/model/notification_model.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:bloc/bloc.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc(AbstractNotificationsRepository notificationsRepository)
      : super(NotificationsInitial()) {
    on<FetchNotificationsEvent>((event, emit) async {
      emit(NotificationsLoading());
      try {
        final notifications = await notificationsRepository.seeNotifications();
        if (notifications != null) {
          print(notifications);
          emit(NotificationsLoaded(notifications: notifications));
        } else {
          emit(NotificationsEmpty());
        }
      } catch (e) {
        emit(NotificationsFailure(e.toString()));
      }
    });

    on<FetchUserProfileInNotifications>((event, emit) async {
      emit(NotificationsLoading());
      try {
        final userProfile =
            await notificationsRepository.fetchUserProfile(event.username);
        if (userProfile != null) {
          emit(UserProfileLoadedInNotification(userProfile));
        } else {
          emit(NotificationsFailure("Profile not found"));
        }
      } catch (e) {
        emit(NotificationsFailure(e.toString()));
      }
    });

    on<DeleteCommentInNotifications>((event, emit) async {
      try {
        final ErrorModel result = await notificationsRepository
            .deleteCommentInNotifications(event.deleteCommentId);
        if (result.ok) {
          if (state is NotificationsLoaded) {
            final currentState = state as NotificationsLoaded;
            final updatedPhotos = currentState.user?.photos?.map((photo) {
              final updatedComments = photo.comments
                  ?.where((comment) => comment?.id != event.deleteCommentId)
                  .toList();
              return photo.copyWith(comments: updatedComments);
            }).toList();
            final updatedUser =
                currentState.user?.copyWith(photos: updatedPhotos);
            if (updatedUser != null) {
              emit(UserProfileLoadedInNotification(updatedUser));
            } else {
              emit(NotificationsFailure("Profile not found"));
            }
          }
        } else {
          emit(NotificationsFailure(result.error ?? ''));
        }
      } catch (e) {
        emit(NotificationsFailure(e.toString()));
      }
    });

    on<ToggleLikeInNotifications>((event, emit) async {
      try {
        await notificationsRepository.toggleLike(
            event.toggleLikeId, event.value);
        if (state is UserProfileLoadedInNotification) {
          final currentState = state as UserProfileLoadedInNotification;
          final updatedRecs = currentState.user.photos?.map((photo) {
            if (photo.id == event.toggleLikeId) {
              bool isLiked = photo.isLiked ?? false;
              bool isDisliked = photo.isDisliked ?? false;

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
                  isLiked ? (photo.likes ?? 0) + 1 : (photo.likes ?? 0) - 1;

              return photo.copyWith(
                isLiked: isLiked,
                isDisliked: isDisliked,
                likes: likes,
              );
            }
            return photo;
          }).toList();
          final updatedPhoto = currentState.user.copyWith(photos: updatedRecs);
          emit(UserProfileLoadedInNotification(updatedPhoto));
        }
      } catch (e) {
        emit(NotificationsFailure(e.toString()));
      }
    });
  }
}
