import 'package:bibinto/src/features/profile/model/user_model.dart';

class FollowersResponse {
  final List<UserModel> followers;
  final int totalPages;

  FollowersResponse({required this.followers, required this.totalPages});
}
