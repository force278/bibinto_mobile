import 'dart:io';

import 'package:bibinto/src/common/widgets/model/error_model.dart';
import 'package:bibinto/src/features/profile/model/followers_response.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';

abstract interface class AbstractProfileRepository {
  Future<UserModel?> isMe();

  Future<UserModel?> fetchUserProfile(String username);

  Future<bool> followUser(String username);

  Future<bool> unFollowUser(String username);

  Future<bool> editPassword(String oldPassword, String newPassword);

  Future<List<File>> loadImages();

  Future<File?> cropImage(File originalImage);

  Future<String?> getUrlUploadPhoto();

  Future<String?> uploadPhoto(File imageFile);

  Future<bool> editProfile({
    String? firstName,
    String? lastName,
    String? username,
    String? bio,
  });

  Future<bool> createRequest(String payload);

  Future<bool> officialRequest(String file);

  Future<FollowersResponse> seeFollowers(String username, int page);

  Future<List<UserModel>> seeFollowing(String username, int lastId);

  Future<bool> toggleLike(int toggleLikeId, int value);

  Future<bool> deletePhoto(int deletePhotoId);

  Future<ErrorModel> banUser(int banUserId);

  Future<ErrorModel> deleteCommentInProfile(int deleteCommentId);
}
