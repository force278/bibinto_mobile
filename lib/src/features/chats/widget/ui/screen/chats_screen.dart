import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/features/chats/bloc/chats_bloc.dart';
import 'package:bibinto/src/features/chats/model/dialog_model.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Localized.of(context).messages,
      ),
      body: BlocBuilder<ChatsBloc, ChatsState>(
        builder: (context, state) {
          switch (state) {
            case ChatsLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ChatsLoaded():
              return DialogsList(
                dialogs: state.dialogs,
              );
            case ChatsFailure():
              return const Center(
                child: Text('Произошла ошибка'),
              );
          }
          return Container(
            color: Colors.white,
          );
        },
      ),
    );
  }
}

class DialogsList extends StatefulWidget {
  const DialogsList({
    super.key,
    required this.dialogs,
  });

  final List<DialogModel> dialogs;

  @override
  State<DialogsList> createState() => _DialogsListState();
}

class _DialogsListState extends State<DialogsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: widget.dialogs.isNotEmpty
            ? ListView.builder(
                itemCount: widget.dialogs.length,
                itemBuilder: (context, index) {
                  final otherUser = widget.dialogs[index].users
                      .firstWhere((user) => !user.isMe);

                  final username = otherUser.username;
                  final avatar = otherUser.avatar;
                  final userId = otherUser.id;

                  widget.dialogs[index].messages
                      .sort((a, b) => b.createdAt.compareTo(a.createdAt));
                  final lastMessage =
                      widget.dialogs[index].messages.first.payload;
                  final isRead = widget.dialogs[index].messages.isNotEmpty &&
                          index < widget.dialogs[index].messages.length
                      ? widget.dialogs[index].messages[index].read
                      : false;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: InkWell(
                          onTap: () async {
                            final result = await AutoRouter.of(context).push(
                              ChatRootRoute(
                                userId: userId ?? 0,
                                dialogId: widget.dialogs[index].id,
                                title: username,
                              ),
                            );
                            if (result != null && result is DialogModel) {
                              setState(() {
                                widget.dialogs[index] = result;
                                if (!(widget.dialogs[index].messages.last.user
                                        ?.isMe ??
                                    false)) {
                                  for (var message
                                      in widget.dialogs[index].messages) {
                                    message = message.copyWith(read: true);
                                  }
                                }
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: avatar != null
                                        ? Image.network(
                                            avatar,
                                            height: 50,
                                            width: 50,
                                          )
                                        : const Icon(
                                            Icons.person,
                                            size: 50,
                                            color: Color.fromRGBO(
                                                174, 174, 178, 1),
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        username,
                                        style: const TextStyle(
                                          fontFamily: 'Golos Text',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                          color: Color.fromRGBO(31, 31, 44, 1),
                                        ),
                                      ),
                                      Text(
                                        lastMessage,
                                        style: const TextStyle(
                                          fontFamily: 'Golos Text',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color:
                                              Color.fromRGBO(118, 118, 140, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              widget.dialogs[index].messages.first.user?.isMe ??
                                      false
                                  ? SvgPicture.asset(
                                      isRead
                                          ? 'assets/icons/read.svg'
                                          : 'assets/icons/notRead.svg',
                                      height: 18,
                                      width: 18,
                                    )
                                  : widget.dialogs[index].unreadTotal == 0
                                      ? const SizedBox()
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          height: 18,
                                          decoration: const BoxDecoration(
                                            color:
                                                Color.fromRGBO(24, 119, 242, 1),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            widget.dialogs[index].unreadTotal
                                                .toString(),
                                            style: const TextStyle(
                                              fontFamily: 'Golos Text',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              color: Color.fromRGBO(
                                                  225, 225, 225, 1),
                                            ),
                                          ),
                                        ),
                            ],
                          ),
                        ),
                      ),
                      customDivider(),
                    ],
                  );
                },
              )
            : Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/Chats.svg'),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 310,
                        child: Text(
                          Localized.of(context).subscribeToUsers,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Golos Text',
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                            color: Color.fromRGBO(118, 118, 140, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

Widget customDivider() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 15),
    child: Divider(
      color: Color.fromRGBO(242, 242, 247, 1),
      height: 1,
    ),
  );
}
