import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  MessageModel({
    this.id = 0,
    this.payload = '',
    this.user,
    this.read = false,
    this.createdAt = '',
    this.updatedAt,
    this.dialogId,
  });

  final int id;
  final String payload;
  final UserModel? user;
  final bool read;
  final String createdAt;
  final String? updatedAt;
  final int? dialogId;

  MessageModel copyWith({
    int? id,
    String? payload,
    UserModel? user,
    bool? read,
    String? createdAt,
    String? updatedAt,
    int? dialogId,
  }) {
    return MessageModel(
      id: id ?? this.id,
      payload: payload ?? this.payload,
      user: user ?? this.user,
      read: read ?? this.read,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? updatedAt,
      dialogId: dialogId ?? this.dialogId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MessageModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
