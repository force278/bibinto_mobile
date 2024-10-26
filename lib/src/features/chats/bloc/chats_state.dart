part of 'chats_bloc.dart';

class ChatsState {}

class ChatsInitial extends ChatsState {}

class ChatsLoading extends ChatsState {}

class ChatsLoaded extends ChatsState {
  final List<DialogModel> dialogs;

  ChatsLoaded(this.dialogs);

  List<Object> get props => [dialogs];
}

class ChatsFailure extends ChatsState {
  final String message;
  final DialogModel? dialog;

  ChatsFailure(this.message, [this.dialog]);

  List<Object?> get props => [message, dialog];
}

class ChatFailure extends ChatsState {
  final String message;
  final DialogModel? dialog;

  ChatFailure(this.message, this.dialog);

  List<Object?> get props => [message, dialog];
}

class ChatLoaded extends ChatsState {
  final DialogModel dialog;

  ChatLoaded(this.dialog);

  Object get props => [dialog];
}

class ChatsMessageSent extends ChatsState {}

class ChatUpdated extends ChatsState {
  final DialogModel dialog;

  ChatUpdated(this.dialog);
}

class DialogUpdateReceived extends ChatsState {
  final MessageModel newMessage;

  DialogUpdateReceived(this.newMessage);
}
