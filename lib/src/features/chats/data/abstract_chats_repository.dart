import 'package:bibinto/src/features/chats/model/dialog_model.dart';

abstract interface class AbstractChatsRepository {
  Future<List<DialogModel>?> seeDialogs();

  Future<DialogModel?> seeDialog(int userId, int? seeDialogId);

  Future<bool> readDialog(int readDialogId);

  Future<bool> sendMessage(String payload, int userId);
}
