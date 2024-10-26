part of 'chats_bloc.dart';

class ChatsEvent {}

class FetchDialogs extends ChatsEvent {}

class FetchDialog extends ChatsEvent {
  final int userId;
  final int? dialogId;

  FetchDialog(this.userId, {this.dialogId});
}

class ReadDialogEvent extends ChatsEvent {
  final int userId;
  final int dialogId;

  ReadDialogEvent(this.userId, {required this.dialogId});

  List<Object> get props => [dialogId];
}

class SendMessageEvent extends ChatsEvent {
  final String payload;
  final int userId;
  final int dialogId;

  SendMessageEvent(this.payload, this.userId, this.dialogId);
}

class SubscribeToDialogUpdates extends ChatsEvent {
  final int dialogId;

  SubscribeToDialogUpdates(this.dialogId);
}
