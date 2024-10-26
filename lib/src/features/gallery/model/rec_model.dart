import 'package:bibinto/src/features/gallery/model/comments_model.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rec_model.g.dart';

@JsonSerializable()
class RecModel {
  const RecModel({
    required this.id,
    required this.user,
    required this.file,
    this.caption,
    required this.likes,
    required this.commentsNumber,
    this.comments,
    this.hashtags,
    required this.createdAt,
    this.updatedAt,
    required this.isMine,
    required this.isDisliked,
    required this.isLiked,
  });

  final int id;
  final UserModel user;
  final String file;
  final String? caption;
  final int likes;
  final int? commentsNumber;
  final List<CommentsModel?>? comments;
  final List? hashtags;
  final String createdAt;
  final String? updatedAt;
  final bool isMine;
  final bool isDisliked;
  final bool isLiked;

  RecModel copyWith({
    int? id,
    UserModel? user,
    String? file,
    String? caption,
    int? likes,
    int? commentsNumber,
    List<CommentsModel?>? comments,
    List? hashtags,
    String? createdAt,
    String? updatedAt,
    bool? isMine,
    bool? isDisliked,
    bool? isLiked,
  }) {
    return RecModel(
      id: id ?? this.id,
      user: user ?? this.user,
      file: file ?? this.file,
      caption: caption ?? this.caption,
      likes: likes ?? this.likes,
      commentsNumber: commentsNumber ?? this.commentsNumber,
      comments: comments ?? this.comments,
      hashtags: hashtags ?? this.hashtags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isMine: isMine ?? this.isMine,
      isDisliked: isDisliked ?? this.isDisliked,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  factory RecModel.fromJson(Map<String, dynamic> json) =>
      _$RecModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecModelToJson(this);
}
