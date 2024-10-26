import 'package:bibinto/src/features/gallery/model/comments_model.dart';
import 'package:bibinto/src/features/notifications/model/like_model.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  const NotificationModel({
    this.like,
    this.comment,
    this.sub,
  });

  final LikeModel? like;
  final CommentsModel? comment;
  final UserModel? sub;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.like == like &&
        other.comment == comment &&
        other.sub == sub;
  }

  @override
  int get hashCode => Object.hash(
        like,
        comment,
        sub,
      );

  @override
  String toString() {
    return 'NotificationModel(like: $like, comment: $comment, sub: $sub)';
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      like: json['like'] != null ? LikeModel.fromJson(json['like']) : null,
      comment: json['comment'] != null
          ? CommentsModel.fromJson(json['comment'])
          : null,
      sub: json['sub'] != null ? UserModel.fromJson(json['sub']) : null,
    );
  }

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
