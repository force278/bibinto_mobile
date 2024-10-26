import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/domain/local_storage.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LocalStorage localStorage = LocalStorage();

    const textStyle = TextStyle(
      fontFamily: 'Golos Text',
      fontWeight: FontWeight.w400,
      fontSize: 17,
      color: Color.fromRGBO(31, 31, 44, 1),
    );

    return Scaffold(
      appBar: CustomAppBar(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                AutoRouter.of(context).replace(const ProfileRoute());
              },
              child: SvgPicture.asset(
                'assets/icons/back.svg',
                height: 36,
                width: 36,
              ),
            ),
          ],
        ),
        title: Localized.of(context).settings,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  AutoRouter.of(context).push(
                    const EditPasswordRoute(),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/lock.svg',
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          Localized.of(context).changePass,
                          style: textStyle,
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      'assets/icons/next.svg',
                    ),
                  ],
                ),
              ),
              customDivider(),
              InkWell(
                onTap: () {
                  AutoRouter.of(context).push(
                    const ConfirmAccRoute(),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/confirm.svg',
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          Localized.of(context).confirmAcc,
                          style: textStyle,
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      'assets/icons/next.svg',
                    ),
                  ],
                ),
              ),
              customDivider(),
              InkWell(
                onTap: () {
                  AutoRouter.of(context).push(
                    const SupportRoute(),
                  );
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/question.svg',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      Localized.of(context).writeSupport,
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              customDivider(),
              InkWell(
                onTap: () async {
                  await localStorage.write('Token', '');
                  AutoRouter.of(context)
                      .replace(const AuthenticationRootRoute());
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/logout.svg',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      Localized.of(context).logout,
                      style: textStyle.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              customDivider(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customDivider() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 20),
    child: Divider(
      color: Color.fromRGBO(242, 242, 247, 1),
      height: 1,
    ),
  );
}
