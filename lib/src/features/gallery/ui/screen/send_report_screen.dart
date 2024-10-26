import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/back_button.dart';
import 'package:bibinto/src/features/gallery/bloc/gallery_bloc.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SendReportScreen extends StatefulWidget {
  const SendReportScreen({
    super.key,
    required this.themeReport,
    required this.recs,
  });

  final String themeReport;
  final UserModel recs;

  @override
  State<SendReportScreen> createState() => _SendReportScreenState();
}

class _SendReportScreenState extends State<SendReportScreen> {
  late TextEditingController enterReportController;

  @override
  void initState() {
    super.initState();
    enterReportController = TextEditingController();
  }

  @override
  void dispose() {
    enterReportController.dispose();
    super.dispose();
  }

  void sendReport() {
    final String textReport =
        '${widget.themeReport}\n${enterReportController.text}';

    final recs = widget.recs;

    BlocProvider.of<GalleryBloc>(context)
        .add(ReportPhotoEvent(recs.id ?? 0, textReport));
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontFamily: 'Golos Text',
      fontWeight: FontWeight.w400,
      fontSize: 17,
      color: Color.fromRGBO(31, 31, 44, 1),
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leadingWidth: 70,
        actions: [
          TextButton(
            onPressed: () {
              sendReport();
            },
            child: Text(
              Localized.of(context).done,
              style: const TextStyle(
                fontFamily: 'Golos Text',
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: Color.fromRGBO(24, 119, 242, 1),
              ),
            ),
          )
        ],
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
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
                Text(
                  Localized.of(context).addComment,
                  style: textStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: enterReportController,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    label: Text(
                      Localized.of(context).enterYourComment,
                      style: const TextStyle(
                        fontFamily: 'Golos Text',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color.fromRGBO(174, 174, 178, 1),
                      ),
                    ),
                    alignLabelWithHint: true,
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: const Color.fromRGBO(242, 242, 247, 1),
                    filled: true,
                  ),
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
