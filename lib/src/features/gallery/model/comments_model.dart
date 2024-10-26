import 'package:bibinto/src/features/gallery/model/photo_model.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comments_model.g.dart';

@JsonSerializable()
class CommentsModel {
  const CommentsModel({
    this.id,
    this.user,
    this.photo,
    this.payload,
    this.createdAt,
    this.updatedAt,
    this.isMine,
    this.read,
  });

  final int? id;
  final UserModel? user;
  final PhotoModel? photo;
  final String? payload;
  final String? createdAt;
  final String? updatedAt;
  final bool? isMine;
  final bool? read;

  factory CommentsModel.fromJson(Map<String, dynamic> json) =>
      _$CommentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsModelToJson(this);
}
