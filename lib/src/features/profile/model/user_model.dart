import 'package:bibinto/src/features/gallery/model/photo_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final bool? admin;
  final String? avatar;
  final String? bio;
  final String? createdAt;
  final String? firstName;
  final String? email;
  final int? id;
  final bool isMe;
  final String username;
  final bool? isFollowing;
  final String? lastName;
  final bool? official;
  final int? totalFollowers;
  final int? totalFollowing;
  final String? updatedAt;
  final int? phone;
  final List<PhotoModel>? photos;
  final bool? read;

  const UserModel(
      {this.admin,
      this.avatar,
      this.bio,
      this.createdAt,
      this.firstName,
      this.email,
      this.id,
      this.isMe = false,
      required this.username,
      this.isFollowing,
      this.lastName,
      this.official,
      this.totalFollowers = 0,
      this.totalFollowing = 0,
      this.updatedAt,
      this.phone,
      this.photos,
      this.read});

  UserModel copyWith(
      {bool? admin,
      String? avatar,
      String? bio,
      String? createdAt,
      String? firstName,
      String? email,
      int? id,
      bool? isMe,
      String? username,
      bool? isFollowing,
      String? lastName,
      bool? official,
      int? totalFollowers,
      int? totalFollowing,
      String? updatedAt,
      int? phone,
      List<PhotoModel>? photos,
      bool? read}) {
    return UserModel(
      admin: admin ?? this.admin,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      firstName: firstName ?? this.firstName,
      email: email ?? this.email,
      id: id ?? this.id,
      isMe: isMe ?? this.isMe,
      username: username ?? this.username,
      isFollowing: isFollowing ?? this.isFollowing,
      lastName: lastName ?? this.lastName,
      official: official ?? this.official,
      totalFollowers: totalFollowers ?? this.totalFollowers,
      totalFollowing: totalFollowing ?? this.totalFollowing,
      updatedAt: updatedAt ?? this.updatedAt,
      phone: phone ?? this.phone,
      photos: photos ?? this.photos,
      read: read ?? this.read,
    );
  }

  @override
  String toString() {
    return 'UserModel(admin: $admin, avatar: $avatar, bio: $bio, createdAt: $createdAt, firstName: $firstName, email: $email, id: $id, isMe: $isMe, username: $username, isFollowing: $isFollowing, lastName: $lastName, official: $official, totalFollowers: $totalFollowers, totalFollowing: $totalFollowing, updatedAt: $updatedAt, phone: $phone, photos: $photos, read:$read)';
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
