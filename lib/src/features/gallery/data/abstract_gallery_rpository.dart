import 'package:bibinto/src/common/widgets/model/error_model.dart';
import 'package:bibinto/src/features/gallery/model/rec_model.dart';
import 'package:bibinto/src/features/profile/model/followers_response.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';

abstract interface class AbstractGalleryRepository {
  Future<List<RecModel?>> fetchRecs();

  Future<List<RecModel?>> fetchFeed(int offset);

  Future<bool> createComment(int photoId, String payload);

  Future<bool> toggleLike(int toggleLikeId, int value);

  Future<bool> reportPhoto(int photoId, String? reportText);

  Future<bool> followUser(String username);

  Future<bool> unFollowUser(String username);

  Future<FollowersResponse> seeFollowers(String username, int page);

  Future<List<UserModel>> seeUserFollowing(String username, int lastId);

  Future<bool> deletePhoto(int deletePhotoId);

  Future<ErrorModel> banUser(int banUserId);

  Future<UserModel?> fetchUserProfile(String username);

  Future<RecModel?> getRec();

  Future<ErrorModel> deleteCommentInGallery(int deleteCommentId);
}
