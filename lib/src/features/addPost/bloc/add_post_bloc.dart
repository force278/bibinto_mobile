import 'package:bibinto/src/features/addPost/data/abstract_add_post_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc(AbstractAddPostRepository addPostRepository)
      : super(AddPostInitial()) {
    on<PublishPhotoEvent>((event, emit) async {
      emit(AddPostLoading());
      try {
        final bool success =
            await addPostRepository.publishPhoto(event.file, event.caption);
        if (success) {
          emit(AddPostSuccess());
        } else {
          emit(const AddPostFailure("Не удалось опубликовать фото."));
        }
      } catch (e) {
        emit(AddPostFailure(e.toString()));
      }
    });
  }
}
