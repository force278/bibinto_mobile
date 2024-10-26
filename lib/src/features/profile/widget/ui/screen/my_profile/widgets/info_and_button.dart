import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/custom_linear_button.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:flutter/material.dart';

Widget infoAndButton(
  BuildContext context,
  UserModel user,
) {
  const TextStyle styleForInt = TextStyle(
    fontFamily: 'Golos Text',
    fontWeight: FontWeight.w500,
    fontSize: 19,
    color: Color.fromRGBO(31, 31, 44, 1),
  );
  const TextStyle styleForStr = TextStyle(
    fontFamily: 'Golos Text',
    fontWeight: FontWeight.w400,
    fontSize: 15,
    color: Color.fromRGBO(118, 118, 140, 1),
  );

  void changeProfile() {
    AutoRouter.of(context).push(ChangeProfileRoute(user: user));
  }

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                '${user.photos?.length ?? 0}',
                style: styleForInt,
              ),
              Text(
                Localized.of(context).countPost,
                style: styleForStr,
              ),
            ],
          ),
          InkWell(
            onTap: () {
              AutoRouter.of(context).push(
                FollowersRoute(username: user.username),
              );
            },
            child: Column(
              children: [
                Text(
                  '${user.totalFollowers}',
                  style: styleForInt,
                ),
                Text(
                  Localized.of(context).countSubscribers,
                  style: styleForStr,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              AutoRouter.of(context).push(
                FollowingRoute(username: user.username),
              );
            },
            child: Column(
              children: [
                Text(
                  '${user.totalFollowing}',
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
      customLinearButton(
        title: Localized.of(context).editProfile,
        func: changeProfile,
        isEnabled: true,
        buttonColor: const Color.fromRGBO(242, 242, 247, 1),
        icon: const Icon(
          Icons.edit,
          size: 17,
          color: Color.fromRGBO(118, 118, 140, 1),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Golos Text',
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: Color.fromRGBO(118, 118, 140, 1),
        ),
      ),
    ],
  );
}
