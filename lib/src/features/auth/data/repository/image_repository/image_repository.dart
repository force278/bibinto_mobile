import 'dart:io';

import 'package:bibinto/src/features/auth/data/repository/image_repository/abstract_image_repository.dart';
import 'package:bibinto/src/graphql_config/graphql_config.dart';
import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageRepository implements AbstractImageRepository {
  static GraphQLConfig graphQLConfig = GraphQLConfig();

  var dio = Dio();

  @override
  Future<File?> pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    return returnedImage != null ? File(returnedImage.path) : null;
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
}
