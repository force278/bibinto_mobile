import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/custom_linear_button.dart';
import 'package:bibinto/src/features/profile/bloc/profile_bloc.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoAndButton extends StatefulWidget {
  const InfoAndButton({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<InfoAndButton> createState() => _InfoAndButtonState();
}

class _InfoAndButtonState extends State<InfoAndButton> {
  final TextStyle styleForInt = const TextStyle(
    fontFamily: 'Golos Text',
    fontWeight: FontWeight.w500,
    fontSize: 19,
    color: Color.fromRGBO(31, 31, 44, 1),
  );

  final TextStyle styleForStr = const TextStyle(
    fontFamily: 'Golos Text',
    fontWeight: FontWeight.w400,
    fontSize: 15,
    color: Color.fromRGBO(118, 118, 140, 1),
  );

  void createSubscribe() {
    widget.user.isFollowing ?? false
        ? BlocProvider.of<ProfileBloc>(context).add(
            UnFollowUserEvent(widget.user.username),
          )
        : BlocProvider.of<ProfileBloc>(context).add(
            FollowUserEvent(widget.user.username),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  '${widget.user.photos?.length ?? 0}',
                  style: styleForInt,
                ),
                Text(
                  Localized.of(context).countPost,
                  style: styleForStr,
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                AutoRouter.of(context).push(
                  FollowersRoute(username: widget.user.username),
                );
              },
              child: Column(
                children: [
                  Text(
                    '${widget.user.totalFollowers}',
                    style: styleForInt,
                  ),
                  Text(
                    Localized.of(context).countSubscribers,
                    style: styleForStr,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                AutoRouter.of(context).push(
                  FollowingRoute(username: widget.user.username),
                );
              },
              child: Column(
                children: [
                  Text(
                    '${widget.user.totalFollowing}',
                    style: styleForInt,
                  ),
                  Text(
                    Localized.of(context).countSubscription,
                    style: styleForStr,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: customLinearButton(
                title: widget.user.isFollowing ?? false
                    ? Localized.of(context).unsubscribe
                    : Localized.of(context).subscribe,
                func: createSubscribe,
                isEnabled: widget.user.isFollowing ?? false,
                buttonColor: const Color.fromRGBO(242, 242, 247, 1),
                textStyle: TextStyle(
                  fontFamily: 'Golos Text',
                  fontWeight: FontWeight.w400,
                  fontSize: widget.user.isFollowing ?? false ? 15 : 16,
                  color: widget.user.isFollowing ?? false
                      ? const Color.fromRGBO(118, 118, 140, 1)
                      : const Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            widget.user.isFollowing ?? false
                ? InkWell(
                    onTap: () {
                      AutoRouter.of(context).push(
                        ChatRootRouteInProfile(
                          userId: widget.user.id ?? 0,
                          title: widget.user.username,
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(108, 242, 254, 1),
                            Color.fromRGBO(41, 54, 255, 1),
                            Color.fromRGBO(254, 45, 183, 1),
                          ],
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/chat.svg',
                        height: 20,
                        width: 20,
                        fit: BoxFit.none,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
