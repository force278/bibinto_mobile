import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/back_button.dart';
import 'package:bibinto/src/common/widgets/custom_linear_button.dart';
import 'package:bibinto/src/features/profile/bloc/profile_bloc.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/widgets/custom_app_bar.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/settings/settings_points/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  TextEditingController textSupportComtroller = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    _isButtonEnabled = true;
    super.initState();
  }

  void emptyText() {
    setState(() {
      if (textSupportComtroller.text.isEmpty) {
        _isButtonEnabled = true;
      } else {
        _isButtonEnabled = false;
      }
    });
  }

  @override
  void dispose() {
    textSupportComtroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Localized.of(context).textToSupport,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: backButton(context),
            ),
          ],
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
              textField(
                context: context,
                controller: textSupportComtroller,
                onChanged: (value) => emptyText(),
                maxLines: 3,
                textStyle: const TextStyle(
                  fontFamily: 'Golos Text',
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: Color.fromRGBO(31, 31, 44, 1),
                ),
                label: Localized.of(context).textToSupport,
              ),
              const SizedBox(
                height: 15,
              ),
              customLinearButton(
                title: Localized.of(context).send,
                isEnabled: _isButtonEnabled,
                func: () {
                  if (!_isButtonEnabled) {
                    BlocProvider.of<ProfileBloc>(context).add(
                      CreateRequestEvent(textSupportComtroller.text),
                    );
                    Navigator.of(context).pop();
                  } else {
                    print('ошибка отправки формы в техподдержку');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
