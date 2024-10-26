import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/back_button.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key, required this.recs});
  final UserModel recs;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontFamily: 'Golos Text',
      fontWeight: FontWeight.w400,
      fontSize: 17,
      color: Color.fromRGBO(31, 31, 44, 1),
    );

    void openSendReportPage({
      required String themeReport,
    }) {
      AutoRouter.of(context).push(
        SendReportRoute(
          themeReport: themeReport,
          recs: recs,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        leadingWidth: 70,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: backButton(context),
            ),
          ],
        ),
        title: Text(
          Localized.of(context).complaint,
          style: const TextStyle(
            fontFamily: 'Golos Text',
            fontWeight: FontWeight.w500,
            fontSize: 19,
            color: Color.fromRGBO(31, 31, 44, 1),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color.fromRGBO(242, 242, 247, 1),
            height: 1.0,
          ),
        ),
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
            children: [
              Text(
                Localized.of(context).descriptionOfReport,
                style: textStyle,
              ),
              customDivider(),
              InkWell(
                onTap: () {
                  openSendReportPage(
                    themeReport: Localized.of(context).spam,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Localized.of(context).spam,
                      style: textStyle,
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
                  openSendReportPage(
                    themeReport: Localized.of(context).fraud,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Localized.of(context).fraud,
                      style: textStyle,
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
                  openSendReportPage(
                    themeReport: Localized.of(context).frankImages,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Localized.of(context).frankImages,
                      style: textStyle,
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
                  openSendReportPage(
                    themeReport: Localized.of(context).copyrightInfringement,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Localized.of(context).copyrightInfringement,
                      style: textStyle,
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
                  openSendReportPage(
                    themeReport: Localized.of(context).other,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Localized.of(context).other,
                      style: textStyle,
                    ),
                    SvgPicture.asset(
                      'assets/icons/next.svg',
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
