import 'package:bibinto/src/common/widgets/model/error_model.dart';
import 'package:bibinto/src/features/gallery/data/abstract_gallery_rpository.dart';
import 'package:bibinto/src/features/gallery/model/rec_model.dart';
import 'package:bibinto/src/features/profile/model/followers_response.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:bibinto/src/graphql_config/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GalleryRepository implements AbstractGalleryRepository {
  static GraphQLConfig graphQLConfig = GraphQLConfig();

  @override
  Future<List<RecModel?>> fetchRecs() async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final QueryOptions options = QueryOptions(
      document: gql('''
      query seeRec {
        seeRec {
          ...PostFragment
          caption
          comments {
            ...CommentFragment
            __typename
          }
          hashtags {
            ...HashtagsFragment
            __typename
          }
          user {
            username
            avatar
            official
            isFollowing
            __typename
          }
          createdAt
          updatedAt
          isMine
          isLiked
          isDisliked
          __typename
        }
      }

      fragment PostFragment on Photo {
        id
        file
        likes
        commentsNumber
        __typename
      }

      fragment CommentFragment on Comment {
        id
        user {
          avatar
          username
          official
          __typename
        }
        payload
        createdAt
        updatedAt
        isMine
        __typename
      }

      fragment HashtagsFragment on Hashtag {
        id
        hashtag
        totalPhotos
        createdAt
        updatedAt
        __typename
      }
    '''),
    );

    final QueryResult result = await client.query(options);

    if (!result.hasException) {
      var rawData = result.data?['seeRec'];
      if (rawData != null) {
        List<dynamic> data = rawData as List;
        List<RecModel?> feed =
            data.map((rec) => RecModel.fromJson(rec)).toList();
        return feed;
      } else {
        return [];
      }
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<List<RecModel?>> fetchFeed(int offset) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final QueryOptions options = QueryOptions(
      document: gql('''
      query SeeFeed(\$offset: Int!) {
        seeFeed(offset: \$offset) {
          ...PostFragment
          caption
          comments {
            ...CommentFragment
            __typename
          }
          user {
            username
            avatar
            official
            isMe
            __typename
          }
          createdAt
          updatedAt
          isMine
          isLiked
          isDisliked
          __typename
        }
      }

      fragment PostFragment on Photo {
        id
        file
        likes
        commentsNumber
        __typename
      }

      fragment CommentFragment on Comment {
        id
        user {
          avatar
          username
          official
          __typename
        }
        payload
        createdAt
        updatedAt
        isMine
        __typename
      }
    '''),
      variables: {
        'offset': offset,
      },
    );

    final QueryResult result = await client.query(options);

    if (!result.hasException) {
      var rawData = result.data?['seeFeed'];
      if (rawData != null) {
        List<dynamic> data = rawData as List;
        List<RecModel?> feed =
            data.map((rec) => RecModel.fromJson(rec)).toList();
        return feed;
      } else {
        return [];
      }
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<bool> createComment(int photoId, String payload) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final MutationOptions options = MutationOptions(
      document: gql('''
      mutation CreateComment(\$photoId: Int!, \$payload: String!) {
        createComment(photoId: \$photoId, payload: \$payload) {
          ok
          error
          id
        }
      }
    '''),
      variables: {
        'photoId': photoId,
        'payload': payload,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (!result.hasException) {
      var data = result.data?['createComment'];
      return data?['ok'] ?? false;
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

  @override
  Future<bool> reportPhoto(int photoId, String? reportText) async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final MutationOptions options = MutationOptions(
      document: gql('''
    mutation ReportPhoto(\$photoId: Int!, \$reportText: String) {
      reportPhoto(photoId: \$photoId, reportText: \$reportText) {
        ok
        error
        id
      }
    }
  '''),
      variables: {
        'photoId': photoId,
        'reportText': reportText,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (!result.hasException) {
      var data = result.data?['reportPhoto'];
      return data?['ok'] ?? false;
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
  Future<List<UserModel>> seeUserFollowing(String username, int lastId) async {
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
  Future<RecModel?> getRec() async {
    GraphQLClient client = graphQLConfig.clientToQuery.value;
    final QueryOptions options = QueryOptions(
      document: gql('''
    query getRec {
  getRec {
    ...PostFragment
    caption
    user {
      username
      avatar
      official
      isFollowing
      __typename
    }
    createdAt
    isMine
    isLiked
    isDisliked
    __typename
  }
}

fragment PostFragment on Photo {
  id
  file
  likes
  commentsNumber
  __typename
}
    '''),
    );

    final QueryResult result = await client.query(options);

    if (!result.hasException) {
      var rawData = result.data?['getRec'];
      if (rawData != null) {
        return RecModel.fromJson(rawData);
      } else {
        return null;
      }
    } else {
      throw Exception(result.exception.toString());
    }
  }

  @override
  Future<ErrorModel> deleteCommentInGallery(int deleteCommentId) async {
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
