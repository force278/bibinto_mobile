import 'dart:io';

import 'package:bibinto/src/common/widgets/model/error_model.dart';
import 'package:bibinto/src/features/profile/model/followers_response.dart';
import 'package:bibinto/src/graphql_config/graphql_config.dart';
import 'package:bibinto/src/features/profile/data/repository/abstract_profile_repositoru.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileRepository implements AbstractProfileRepository {
  static GraphQLConfig graphQLConfig = GraphQLConfig();

  @override
  Future<UserModel?> isMe() async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final QueryOptions options = QueryOptions(
      document: gql('''
      query Me {
          me {
            admin
            avatar
            bio
            createdAt
            firstName
            email
            id
            isMe
            username
            isFollowing
            lastName
            official
            totalFollowers
            totalFollowing
            updatedAt
          }
        }
      '''),
    );

    await Future.delayed(const Duration(milliseconds: 250));

    final QueryResult result = await client.query(options);

    if (!result.hasException) {
      var data = result.data?['me'];
      if (data == null) {
        print('data is null');
        return null;
      }
      return UserModel.fromJson(data);
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<UserModel?> fetchUserProfile(String username) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final QueryOptions options = QueryOptions(
      document: gql('''
      query seeProfile(\$username: String!) {
  seeProfile(username: \$username) {
    firstName
    lastName
    username
    id
    bio
    avatar
    official
    totalFollowers
    totalFollowing
    photos {
      ...MyPostFragment
      __typename
    }
    isMe
    isFollowing
    __typename
  }
}

fragment MyPostFragment on Photo {
  id
  file
  likes
  isLiked
  createdAt
  updatedAt
  caption
  comments {
    id
    user {
      avatar
      username
      official
      __typename
    }
    payload
    createdAt
    isMine
    __typename
  }
  commentsNumber
  __typename
}
    '''),
      variables: {
        'username': username,
      },
    );

    final QueryResult result = await client.query(options);

    if (!result.hasException) {
      var data = result.data?['seeProfile'];
      if (data == null) {
        return null;
      }
      return UserModel.fromJson(data);
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<bool> followUser(String username) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final MutationOptions options = MutationOptions(
      document: gql('''
    mutation FollowUser(\$username: String!) {
      followUser(username: \$username) {
        ok
        error
        id
      }
    }
  '''),
      variables: {
        'username': username,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (!result.hasException) {
      var data = result.data?['followUser'];
      return data?['ok'] ?? false;
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<bool> unFollowUser(String username) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final MutationOptions options = MutationOptions(
      document: gql('''
    mutation UnFollowUser(\$username: String!) {
      unFollowUser(username: \$username) {
        ok
        error
        id
      }
    }
  '''),
      variables: {
        'username': username,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (!result.hasException) {
      var data = result.data?['unFollowUser'];
      return data?['ok'] ?? false;
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<bool> editPassword(String oldPassword, String newPassword) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final MutationOptions options = MutationOptions(
      document: gql('''
      mutation EditPassword(\$oldPassword: String!, \$newPassword: String!) {
        editPassword(oldPassword: \$oldPassword, newPassword: \$newPassword) {
          ok
          error
          id
        }
      }
    '''),
      variables: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (!result.hasException) {
      var data = result.data?['editPassword'];
      return data?['ok'] ?? false;
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<List<File>> loadImages() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return returnedImage != null ? [File(returnedImage.path)] : [];
  }

  @override
  Future<File?> cropImage(File originalImage) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: originalImage.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      cropStyle: CropStyle.rectangle,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      uiSettings: [
        AndroidUiSettings(
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          rotateClockwiseButtonHidden: false,
          aspectRatioLockEnabled: true,
          aspectRatioPickerButtonHidden: true,
          rotateButtonsHidden: true,
          resetButtonHidden: true,
        ),
      ],
    );

    return croppedFile != null ? File(croppedFile.path) : null;
  }

  @override
  Future<String?> getUrlUploadPhoto() async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final QueryOptions options = QueryOptions(
      document: gql('''
    query Query {
      getUrlUploadPhoto
    }
    '''),
    );

    final QueryResult result = await client.query(options);

    if (!result.hasException) {
      var data = result.data?['getUrlUploadPhoto'];
      if (data == null) {
        return null;
      }
      return data;
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<String?> uploadPhoto(File imageFile) async {
    final String? uploadUrl = await getUrlUploadPhoto();
    if (uploadUrl == null) {
      throw Exception("URL для загрузки не может быть получен.");
    }

    Dio dio = Dio();
    var len = await imageFile.length();

    try {
      var response = await dio.put(uploadUrl,
          data: imageFile.openRead(),
          options: Options(headers: {
            Headers.contentLengthHeader: len,
          }));

      if (response.statusCode == 200) {
        final uploadedUrl = (response.realUri.origin) + (response.realUri.path);
        print('ссылка на загруженое изображение $uploadedUrl');
        return uploadedUrl.toString();
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (error) {
      print('файл не загружен');
      return null;
    }
  }

  @override
  Future<bool> editProfile(
      {String? firstName,
      String? lastName,
      String? username,
      String? bio}) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final MutationOptions options = MutationOptions(
      document: gql('''
    mutation EditProfile(\$firstName: String, \$lastName: String, \$username: String, \$bio: String) {
      editProfile(firstName: \$firstName, lastName: \$lastName, username: \$username, bio: \$bio) {
        ok
        error
        id
      }
    }
    '''),
      variables: {
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'bio': bio,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (!result.hasException) {
      var data = result.data?['editProfile'];
      return data?['ok'] ?? false;
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<bool> createRequest(String payload) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final MutationOptions options = MutationOptions(
      document: gql('''
    mutation CreateRequest(\$payload: String!) {
      createRequest(payload: \$payload) {
        ok
        error
        id
      }
    }
    '''),
      variables: {
        'payload': payload,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (!result.hasException) {
      var data = result.data?['createRequest'];
      return data?['ok'] ?? false;
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<bool> officialRequest(String file) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final MutationOptions options = MutationOptions(
      document: gql('''
    mutation OfficialRequest(\$file: String!) {
      officialRequest(file: \$file) {
        ok
        error
        id
      }
    }
    '''),
      variables: {
        'file': file,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (!result.hasException) {
      var data = result.data?['officialRequest'];
      return data?['ok'] ?? false;
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<FollowersResponse> seeFollowers(String username, int page) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final QueryOptions options = QueryOptions(
      document: gql('''
       query seeFollowers(\$username: String!, \$page: Int!) {
        seeFollowers(username: \$username, page: \$page) {
          followers {
            id
            avatar
            username
            __typename
          }
          ok
          error
          totalPages
          __typename
        }
      }
    '''),
      variables: {
        'username': username,
        'page': page,
      },
    );

    final QueryResult result = await client.query(options);
    if (!result.hasException) {
      var data = result.data?['seeFollowers'];
      if (data != null) {
        List<UserModel> followers = List<UserModel>.from(
          data['followers'].map(
            (item) => UserModel.fromJson(item),
          ),
        );
        return FollowersResponse(
            followers: followers, totalPages: data['totalPages']);
      } else {
        throw Exception('No data available');
      }
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<List<UserModel>> seeFollowing(String username, int lastId) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final QueryOptions options = QueryOptions(
      document: gql('''
      query seeFollowing(\$username: String!, \$lastId: Int) {
  seeFollowing(username: \$username, lastId: \$lastId) {
    error
    following {
      id
      avatar
      username
      __typename
    }
    ok
    __typename
  }
}
    '''),
      variables: {
        'username': username,
        'lastId': lastId,
      },
    );

    final QueryResult result = await client.query(options);
    if (!result.hasException) {
      var data = result.data?['seeFollowing']['following'];
      if (data != null) {
        List<UserModel> followers = List<UserModel>.from(
          data.map(
            (item) => UserModel.fromJson(item),
          ),
        );
        return followers;
      } else {
        throw Exception('No data available');
      }
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<bool> toggleLike(int toggleLikeId, int value) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final MutationOptions options = MutationOptions(
      document: gql('''
      mutation ToggleLike(\$toggleLikeId: Int!, \$value: Int!) {
        toggleLike(id: \$toggleLikeId, value: \$value) {
          ok
          error
          id
        }
      }
    '''),
      variables: {
        'toggleLikeId': toggleLikeId,
        'value': value,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (!result.hasException) {
      var data = result.data?['toggleLike'];
      return data?['ok'] ?? false;
    } else {
      throw Exception(result.exception.toString());
    }
  }

  final streamDoc = gql(
    r'''
subscription AllDialogsUpdates {
  allDialogsUpdates {
    newMessage {
       id
            createdAt
            payload
            read
            user {
              username
              isMe
              __typename
            }
            __typename
    }
    read
    dialogId
  }
}
''',
  );

  @override
  Future<bool> deletePhoto(int deletePhotoId) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final MutationOptions options = MutationOptions(
      document: gql('''
   mutation DeletePhoto(\$deletePhotoId: Int!) {
  deletePhoto(id: \$deletePhotoId) {
    ok
    error
    id
  }
}
  '''),
      variables: {
        'deletePhotoId': deletePhotoId,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (!result.hasException) {
      var data = result.data?['deletePhoto'];
      return data?['ok'] ?? false;
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<ErrorModel> banUser(int banUserId) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final MutationOptions options = MutationOptions(
      document: gql('''
 mutation BanUser(\$banUserId: Int!) {
  banUser(id: \$banUserId) {
    ok
    error
    id
  }
}
  '''),
      variables: {
        'banUserId': banUserId,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (!result.hasException) {
      var data = result.data?['banUser'];
      return ErrorModel.fromJson(data);
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<ErrorModel> deleteCommentInProfile(int deleteCommentId) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final MutationOptions options = MutationOptions(
      document: gql('''
mutation DeleteComment(\$deleteCommentId: Int!) {
  deleteComment(id: \$deleteCommentId) {
    ok
    error
    id
  }
}
  '''),
      variables: {
        'deleteCommentId': deleteCommentId,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (!result.hasException) {
      var data = result.data?['deleteComment'];
      if (data == null) {
        return ErrorModel(ok: false, error: 'Data is null');
      }
      return ErrorModel.fromJson(data);
    } else {
      throw Exception(result.exception.toString());
    }
  }
}
