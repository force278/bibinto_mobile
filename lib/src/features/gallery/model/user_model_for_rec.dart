import 'package:json_annotation/json_annotation.dart';

part 'user_model_for_rec.g.dart';

@JsonSerializable()
class UserModelForRec {
  const UserModelForRec({
    this.avatar,
    required this.username,
    required this.official,
  });

  final String? avatar;
  final String username;
  final bool official;

  factory UserModelForRec.fromJson(Map<String, dynamic> json) =>
      _$UserModelForRecFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelForRecToJson(this);
}
