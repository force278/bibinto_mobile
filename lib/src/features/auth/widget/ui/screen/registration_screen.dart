import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/custom_linear_button.dart';
import 'package:bibinto/src/common/widgets/custom_text_form_field.dart';
import 'package:bibinto/src/common/widgets/error_notification.dart';
import 'package:bibinto/src/common/widgets/lower_button.dart';
import 'package:bibinto/src/features/auth/bloc/auth_bloc.dart';
import 'package:bibinto/src/features/auth/data/user_data.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void registerButton() async {
      final form = formKey.currentState;
      if (form?.validate() ?? false) {
        final email = emailController.text;
        UserData().userEmail = email;
        final authBloc = context.read<AuthBloc>();
        authBloc.add(SendEmail(email));
      }
    }

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is EmailSended) {
          AutoRouter.of(context)
              .push(CodeConfirmationRoute(email: emailController.text));
        } else if (state is CodeVerificationFailure) {
          showCustomErrorNotification(context, 'Ошибка', state.error);
        }
      },
      child: GestureDetector(
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
                            _logo(),
                            const SizedBox(
                              height: 70,
                            ),
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  _buildRegistrationDescription(context),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  customTextFormField(
                                    null,
                                    Localized.of(context).email,
                                    emailController,
                                    (emailController) =>
                                        emailController == null ||
                                                !EmailValidator.validate(
                                                    emailController)
                                            ? ''
                                            : null,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  customLinearButton(
                                    title: Localized.of(context).registration,
                                    func: registerButton,
                                  ),
                                ],
                              ),
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
                    ),
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

Widget _logo() {
  return Image.asset(
    'assets/images/logo.png',
    width: 135,
    height: 31,
  );
}

Widget _buildRegistrationDescription(BuildContext context) {
  return Column(
    children: [
      Text(
        Localized.of(context).signUp,
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
        Localized.of(context).descForRegistration,
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
