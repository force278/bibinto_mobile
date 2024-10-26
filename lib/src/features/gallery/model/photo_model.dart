import 'package:bibinto/src/features/gallery/model/comments_model.dart';
import 'package:bibinto/src/features/gallery/model/hashtag_model.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_model.g.dart';

@JsonSerializable()
class PhotoModel {
  const PhotoModel(
    this.id,
    this.user,
    this.file,
    this.caption,
    this.likes,
    this.commentsNumber,
    this.comments,
    this.hashtags,
    this.createdAt,
    this.updatedAt,
    this.isMine,
    this.isDisliked,
    this.isLiked,
  );

  final int? id;
  final UserModel? user;
  final String file;
  final String? caption;
  final int? likes;
  final int? commentsNumber;
  final List<CommentsModel?>? comments;
  final List<HashtagModel>? hashtags;
  final String? createdAt;
  final String? updatedAt;
  final bool? isMine;
  final bool? isDisliked;
  final bool? isLiked;

  PhotoModel copyWith({
    int? id,
    UserModel? user,
    String? file,
    String? caption,
    int? likes,
    int? commentsNumber,
    List<CommentsModel?>? comments,
    List<HashtagModel>? hashtags,
    String? createdAt,
    String? updatedAt,
    bool? isMine,
    bool? isDisliked,
    bool? isLiked,
  }) {
    return PhotoModel(
      id ?? this.id,
      user ?? this.user,
      file ?? this.file,
      caption ?? this.caption,
      likes ?? this.likes,
      commentsNumber ?? this.commentsNumber,
      comments ?? this.comments,
      hashtags ?? this.hashtags,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
      isMine ?? this.isMine,
      isDisliked ?? this.isDisliked,
      isLiked ?? this.isLiked,
    );
  }

  @override
  String toString() {
    return 'PhotoModel(id: $id, user: ${user.toString()}, file: $file, caption: $caption, likes: $likes, commentsNumber: $commentsNumber, comments: ${comments?.map((comment) => comment?.toString()).toList()}, hashtags: ${hashtags?.map((hashtag) => hashtag.toString()).toList()}, createdAt: $createdAt, updatedAt: $updatedAt, isMine: $isMine, isDisliked: $isDisliked, isLiked: $isLiked,)';
  }

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);
}
