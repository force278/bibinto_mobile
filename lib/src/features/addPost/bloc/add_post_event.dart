part of 'add_post_bloc.dart';

abstract class AddPostEvent extends Equatable {
  const AddPostEvent();

  @override
  List<Object> get props => [];
}

class PublishPhotoEvent extends AddPostEvent {
  final String file;
  final String caption;

  const PublishPhotoEvent(this.file, this.caption);

  @override
  List<Object> get props => [file];
}
