import 'package:bibinto/src/features/chats/model/message_model.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dialog_model.g.dart';

@JsonSerializable()
class DialogModel {
  const DialogModel(
    this.id,
    this.users,
    this.messages,
    this.unreadTotal,
    this.createdAt,
    this.updatedAt,
  );

  final int id;
  final List<UserModel> users;
  final List<MessageModel> messages;
  final int unreadTotal;
  final String createdAt;
  final String? updatedAt;

  DialogModel addMessage(MessageModel message) {
    return copyWith(
      messages: List<MessageModel>.from(messages)..add(message),
    );
  }

  DialogModel copyWith({
    int? id,
    List<UserModel>? users,
    List<MessageModel>? messages,
    int? unreadTotal,
    String? createdAt,
    String? updatedAt,
  }) {
    return DialogModel(
      id ?? this.id,
      users ?? this.users,
      messages ?? this.messages,
      unreadTotal ?? this.unreadTotal,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
    );
  }

  factory DialogModel.fromJson(Map<String, dynamic> json) =>
      _$DialogModelFromJson(json);

  Map<String, dynamic> toJson() => _$DialogModelToJson(this);
}
