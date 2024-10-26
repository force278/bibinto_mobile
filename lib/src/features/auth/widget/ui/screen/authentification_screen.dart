import 'package:bibinto/src/common/widgets/error_notification.dart';
import 'package:bibinto/src/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/custom_text_form_field.dart';
import 'package:bibinto/src/common/widgets/custom_linear_button.dart';
import 'package:bibinto/src/common/widgets/lower_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class AuthentificationScreen extends StatefulWidget {
  const AuthentificationScreen({super.key});

  @override
  State<AuthentificationScreen> createState() => _AuthentificationScreenState();
}

class _AuthentificationScreenState extends State<AuthentificationScreen> {
  TextEditingController nickNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isVisible = false;

  void logIn() {
    if (nickNameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      final authBloc = BlocProvider.of<AuthBloc>(context);

      authBloc.add(LoginStarted(
        username: nickNameController.text.trim(),
        password: passwordController.text.trim(),
      ));
    } else {
      print('пусто');
    }
  }

  @override
  void dispose() {
    nickNameController.dispose();
    passwordController.dispose();
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
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                AutoRouter.of(context).replace(const MainFlowRouter());
              } else if (state is LoginFailure) {
                showCustomErrorNotification(
                  context,
                  'Ошибка входа',
                  state.error.toString(),
                );
              }
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 90, left: 35, right: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 135,
                          height: 31,
                        ),
                        const SizedBox(height: 70),
                        Text(
                          Localized.of(context).entrance,
                          style: const TextStyle(
                            fontFamily: 'Golos Text',
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: Color.fromRGBO(31, 31, 44, 1),
                          ),
                        ),
                        const SizedBox(height: 25),
                        customTextFormField(
                          null,
                          Localized.of(context).nickName,
                          nickNameController,
                          null,
                        ),
                        const SizedBox(height: 10),
                        customTextFormField(
                          null,
                          Localized.of(context).password,
                          passwordController,
                          null,
                          obscureText: !_isVisible,
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
                        ),
                        const SizedBox(height: 17),
                        _forgotPassword(context),
                        const SizedBox(height: 30),
                        customLinearButton(
                          title: Localized.of(context).logIn,
                          func: logIn,
                        ),
                      ],
                    ),
                    signUpPrompt(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _forgotPassword(BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child: GestureDetector(
      onTap: () {},
      child: Text(
        Localized.of(context).forgotPassword,
        style: const TextStyle(
          fontFamily: 'Golos Text',
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Color.fromRGBO(118, 118, 140, 1),
        ),
      ),
    ),
  );
}

Widget signUpPrompt(BuildContext context) {
  return lowerButtom(
    Localized.of(context).noAccount,
    context,
    const RegistrationRoute(),
    Localized.of(context).registration,
  );
}
