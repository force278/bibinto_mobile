import 'dart:io';

abstract interface class AbstractImageRepository {
  Future<File?> pickImageFromCamera();

  Future<List<File>> loadImages();

  Future<File?> cropImage(File originalImage);

  Future<String?> getUrlUploadPhoto();

  Future<String?> uploadPhoto(File imageFile);
}
