import 'package:bibinto/src/features/gallery/model/photo_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hashtag_model.g.dart';

@JsonSerializable()
class HashtagModel {
  const HashtagModel({
    required this.id,
    required this.hashtag,
    required this.photos,
    required this.totalPhotos,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String hashtag;
  final List<PhotoModel> photos;
  final int totalPhotos;
  final String createdAt;
  final String updatedAt;

  factory HashtagModel.fromJson(Map<String, dynamic> json) =>
      _$HashtagModelFromJson(json);

  Map<String, dynamic> toJson() => _$HashtagModelToJson(this);
}
