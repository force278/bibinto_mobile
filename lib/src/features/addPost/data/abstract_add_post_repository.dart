import 'dart:io';

abstract interface class AbstractAddPostRepository {
  Future<File?> pickImageFromCamera();

  Future<List<File>> loadImages();

  Future<File?> cropImage(File originalImage);

  Future<String?> getUrlUploadPhoto();

  Future<String?> uploadPhoto(File imageFile);

  Future<bool> publishPhoto(String file, String caption);
}
