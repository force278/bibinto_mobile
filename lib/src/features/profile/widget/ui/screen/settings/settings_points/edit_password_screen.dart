import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/back_button.dart';
import 'package:bibinto/src/features/profile/bloc/profile_bloc.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/widgets/custom_app_bar.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/settings/settings_points/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  bool _isVisible = false;
  bool _isButtonEnabled = true;
  bool _isPasswordEightCharacters = true;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isButtonEnabled = false;
  }

  void onPasswordChanged(String password) {
    setState(() {
      bool passwordsMatch =
          newPasswordController.text == confirmNewPasswordController.text;

      if (!passwordsMatch) {
        _isButtonEnabled = false;
      } else {
        _isButtonEnabled = true;
      }
    });
  }

  @override
  void dispose() {
    newPasswordController.removeListener(() {
      onPasswordChanged(newPasswordController.text);
    });
    confirmNewPasswordController.removeListener(() {
      onPasswordChanged(confirmNewPasswordController.text);
    });
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    oldPasswordController.dispose();
    super.dispose();
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
      appBar: CustomAppBar(
        action: TextButton(
          onPressed: () {
            if (_isButtonEnabled) {
              BlocProvider.of<ProfileBloc>(context).add(
                EditPasswordEvent(
                  oldPasswordController.text,
                  newPasswordController.text,
                ),
              );
              Navigator.of(context).pop();
            } else {
              print('ошибка');
            }
          },
          child: Text(
            Localized.of(context).done,
            style: TextStyle(
              fontFamily: 'Golos Text',
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: _isButtonEnabled
                  ? const Color.fromRGBO(24, 119, 242, 1)
                  : const Color.fromRGBO(174, 174, 178, 1),
            ),
          ),
        ),
        title: Localized.of(context).password,
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
              children: [
                Text(
                  Localized.of(context).newPasswordDescription,
                  style: textStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                textField(
                  context: context,
                  onChanged: (password) => onPasswordChanged(password),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: _isVisible
                        ? SvgPicture.asset(
                            'assets/icons/visibility.svg',
                            height: 13,
                            width: 13,
                          )
                        : SvgPicture.asset(
                            'assets/icons/visibility_off.svg',
                            height: 20,
                            width: 20,
                          ),
                  ),
                  controller: oldPasswordController,
                  textStyle: textStyle,
                  obscureText: !_isVisible,
                  label: Localized.of(context).currentPassword,
                ),
                const SizedBox(
                  height: 20,
                ),
                textField(
                  context: context,
                  onChanged: (password) => onPasswordChanged(password),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: _isVisible
                        ? SvgPicture.asset(
                            'assets/icons/visibility.svg',
                            height: 13,
                            width: 13,
                          )
                        : SvgPicture.asset(
                            'assets/icons/visibility_off.svg',
                            height: 20,
                            width: 20,
                          ),
                  ),
                  controller: newPasswordController,
                  textStyle: textStyle,
                  label: Localized.of(context).newPassword,
                  obscureText: !_isVisible,
                  isPasswordValid: _isPasswordEightCharacters,
                ),
                const SizedBox(
                  height: 20,
                ),
                textField(
                  context: context,
                  onChanged: (text) =>
                      onPasswordChanged(confirmNewPasswordController.text),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: _isVisible
                        ? SvgPicture.asset(
                            'assets/icons/visibility.svg',
                            height: 13,
                            width: 13,
                          )
                        : SvgPicture.asset(
                            'assets/icons/visibility_off.svg',
                            height: 20,
                            width: 20,
                          ),
                  ),
                  controller: confirmNewPasswordController,
                  textStyle: textStyle,
                  label: Localized.of(context).repeatNewPassword,
                  obscureText: !_isVisible,
                  isPasswordValid: newPasswordController.text ==
                      confirmNewPasswordController.text,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
