import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/back_button.dart';
import 'package:bibinto/src/common/widgets/custom_linear_button.dart';
import 'package:bibinto/src/common/widgets/custom_text_form_field.dart';
import 'package:bibinto/src/common/widgets/lower_button.dart';
import 'package:bibinto/src/features/auth/data/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({
    super.key,
  });

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  bool _isButtonEnabled = true;
  bool _isVisible = false;
  bool _isPasswordEightCharacters = true;

  @override
  void initState() {
    super.initState();
    _isButtonEnabled = false;
  }

  void onPasswordChanged(String password) {
    setState(() {
      // _isPasswordEightCharacters = false;
      // if (passwordController.text.length >= 8) {
      //   _isPasswordEightCharacters = true;
      // }
      bool passwordsMatch = password == repeatPasswordController.text;

      _isButtonEnabled = _isPasswordEightCharacters && passwordsMatch;
    });
  }

  void sendPassword() {
    final password = passwordController.text;
    UserData().password = password;
    AutoRouter.of(context).push(const BasicInformationRoute());
  }

  @override
  void dispose() {
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 90,
                left: 35,
                right: 35,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          backButton(context),
                          const SizedBox(
                            height: 90,
                          ),
                          Column(
                            children: [
                              _buildPasswordDescription(context),
                              const SizedBox(
                                height: 15,
                              ),
                              customTextFormField(
                                null,
                                Localized.of(context).enterPassword,
                                passwordController,
                                null,
                                obscureText: !_isVisible,
                                onChanged: (password) =>
                                    onPasswordChanged(password),
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
                                isPasswordValid: _isPasswordEightCharacters,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              customTextFormField(
                                null,
                                Localized.of(context).repeatPassword,
                                repeatPasswordController,
                                null,
                                obscureText: !_isVisible,
                                onChanged: (text) =>
                                    onPasswordChanged(passwordController.text),
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
                                isPasswordValid: passwordController.text ==
                                    repeatPasswordController.text,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              customLinearButton(
                                title: Localized.of(context).registration,
                                func: sendPassword,
                                isEnabled: !_isButtonEnabled,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  lowerButtom(
                    Localized.of(context).haveAccount,
                    context,
                    const AuthenticationRootRoute(),
                    Localized.of(context).logIn,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildPasswordDescription(BuildContext context) {
  return Column(
    children: [
      Text(
        Localized.of(context).createPassword,
        style: const TextStyle(
          fontFamily: 'Golos Text',
          fontWeight: FontWeight.w500,
          fontSize: 24,
          color: Color.fromRGBO(31, 31, 44, 1),
        ),
      ),
      const SizedBox(
        height: 25,
      ),
      Text(
        Localized.of(context).passwordForLogIn,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Golos Text',
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: Color.fromRGBO(118, 118, 140, 1),
        ),
      ),
    ],
  );
}
