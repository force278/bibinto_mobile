import 'package:bibinto/src/features/gallery/model/photo_model.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'like_model.g.dart';

@JsonSerializable()
class LikeModel {
  const LikeModel(
    this.id,
    this.photo,
    this.value,
    this.user,
    this.createdAt,
    this.read,
  );

  final int id;
  final PhotoModel? photo;
  final int? value;
  final UserModel user;
  final String? createdAt;
  final bool? read;

  factory LikeModel.fromJson(Map<String, dynamic> json) =>
      _$LikeModelFromJson(json);

  Map<String, dynamic> toJson() => _$LikeModelToJson(this);
}
