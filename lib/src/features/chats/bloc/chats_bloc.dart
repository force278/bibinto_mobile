import 'package:bibinto/src/features/chats/data/abstract_chats_repository.dart';
import 'package:bibinto/src/features/chats/model/dialog_model.dart';
import 'package:bibinto/src/features/chats/model/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc(AbstractChatsRepository chatsRepository) : super(ChatsInitial()) {
    on<FetchDialogs>((event, emit) async {
      emit(ChatsLoading());
      try {
        final List<DialogModel>? dialogs = await chatsRepository.seeDialogs();
        if (dialogs != null) {
          emit(ChatsLoaded(dialogs));
        } else {
          emit(ChatsFailure("Dialogs not found"));
        }
      } catch (e) {
        emit(ChatsFailure(e.toString()));
      }
    });

    on<FetchDialog>((event, emit) async {
      emit(ChatsLoading());
      try {
        final DialogModel? dialog =
            await chatsRepository.seeDialog(event.userId, event.dialogId);
        if (dialog != null) {
          emit(ChatLoaded(dialog));
        } else {
          emit(ChatFailure("Dialog not found", dialog));
        }
      } catch (e) {
        emit(ChatsFailure(e.toString()));
      }
    });

    on<ReadDialogEvent>((event, emit) async {
      try {
        bool result = await chatsRepository.readDialog(event.dialogId);
        if (result) {
          add(FetchDialog(event.userId, dialogId: event.dialogId));
        } else {
          emit(ChatsFailure("Failed to mark dialog as read"));
        }
      } catch (e) {
        emit(ChatsFailure(e.toString()));
      }
    });

    on<SendMessageEvent>((event, emit) async {
      try {
        bool result =
            await chatsRepository.sendMessage(event.payload, event.userId);
        if (result) {
          final updatedDialog =
              await chatsRepository.seeDialog(event.userId, event.dialogId);
          if (updatedDialog != null) {
            emit(ChatLoaded(updatedDialog));
          } else {
            emit(ChatsFailure("Failed to load updated dialog"));
          }
        } else {
          emit(ChatsFailure("Failed to send message"));
        }
      } catch (e) {
        emit(ChatsFailure(e.toString()));
      }
    });
  }
}
