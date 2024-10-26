import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/back_button.dart';
import 'package:bibinto/src/common/widgets/custom_linear_button.dart';
import 'package:bibinto/src/common/widgets/lower_button.dart';
import 'package:bibinto/src/features/auth/bloc/auth_bloc.dart';
import 'package:bibinto/src/features/auth/data/repository/auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CodeConfirmationScreen extends StatefulWidget {
  const CodeConfirmationScreen({
    required this.email,
    super.key,
  });

  final String email;

  @override
  State<CodeConfirmationScreen> createState() => _CodeConfirmationScreenState();
}

class _CodeConfirmationScreenState extends State<CodeConfirmationScreen> {
  final authRepository = AuthRepository();
  Timer? _timer;
  bool isEmpty = true;
  bool isButtonEnabled = true;
  bool isTimerVisibility = true;
  num seconds = 60;
  late List<FocusNode> focusNodes;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    _initFields();
    _resetTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initFields() {
    focusNodes = List.generate(6, (_) => FocusNode());
    controllers = List.generate(6, (_) => TextEditingController());
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].addListener(
        () {
          setState(
            () {
              isEmpty =
                  controllers.any((controller) => controller.text.isEmpty);
            },
          );
        },
      );
    }
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) return;
        if (seconds == 0) {
          setState(
            () {
              timer.cancel();
              isButtonEnabled = true;
              isTimerVisibility = false;
              for (final controller in controllers) {
                controller.clear();
              }
              FocusScope.of(context).requestFocus(focusNodes.first);
            },
          );
        } else {
          setState(
            () {
              seconds--;
            },
          );
        }
      },
    );
  }

  void onButtonPressed() {
    final codeString =
        controllers.map((controller) => controller.text).join('');
    if (!controllers.any((controller) => controller.text.isEmpty)) {
      BlocProvider.of<AuthBloc>(context)
          .add(CodeVerificationStarted(email: widget.email, code: codeString));
    }
  }

  void _resetTimer() {
    BlocProvider.of<AuthBloc>(context).add(CodeVerificationReset());
    setState(() {
      seconds = 60;
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is CodeVerificationSuccess) {
          AutoRouter.of(context).push(const CreatePasswordRoute());
        } else if (state is CodeVerificationFailure) {
          print('неверный код подтверждения!');
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
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
                    children: [
                      backButton(context),
                      const SizedBox(height: 90),
                      _buildCodeConfirmationTitle(context),
                      const SizedBox(height: 25),
                      _buildDescriptionText(context),
                      const SizedBox(height: 5),
                      _buildConfirmationTextFields(),
                      const SizedBox(height: 30),
                      _buildResendText(context),
                      const SizedBox(height: 30),
                      customLinearButton(
                        title: Localized.of(context).confirm,
                        func: isButtonEnabled ? onButtonPressed : null,
                        isEnabled: !isButtonEnabled || isEmpty,
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
    );
  }

  Widget _buildCodeConfirmationTitle(BuildContext context) {
    return Text(
      Localized.of(context).codeConfirmation,
      style: const TextStyle(
        fontFamily: 'Golos Text',
        fontWeight: FontWeight.w500,
        fontSize: 24,
        color: Color.fromRGBO(31, 31, 44, 1),
      ),
    );
  }

  Widget _buildDescriptionText(BuildContext context) {
    return Text(
      Localized.of(context).descForCodeConfirm(widget.email),
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'Golos Text',
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: Color.fromRGBO(118, 118, 140, 1),
      ),
    );
  }

  Widget _buildResendText(BuildContext context) {
    return Text(
      Localized.of(context).sendAgain(seconds),
      style: TextStyle(
        fontFamily: 'Golos Text',
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: isTimerVisibility
            ? const Color.fromRGBO(118, 118, 140, 1)
            : Colors.transparent,
      ),
    );
  }

  Widget _buildConfirmationTextFields() {
    List<Widget> fields = List.generate(6, (index) {
      final TextEditingController controller = controllers[index];
      final FocusNode currentFocus = focusNodes[index];
      final FocusNode nextFocus =
          index < 5 ? focusNodes[index + 1] : focusNodes[5];
      return Expanded(
        child: _confirmationTextField(
          controller,
          currentFocus,
          nextFocus,
        ),
      );
    });

    return Row(
      children: fields
          .map((field) => [field, const SizedBox(width: 10)])
          .expand((pair) => pair)
          .toList()
        ..removeLast(),
    );
  }

  Widget _confirmationTextField(
    TextEditingController controller,
    FocusNode focusNode,
    FocusNode nextFocusNode,
  ) {
    final bool hasText = controller.text.isNotEmpty;
    final bool isEmptyAndFocused =
        controller.text.isEmpty || controllers.any((c) => c.text.isEmpty);

    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.number,
          maxLength: 1,
          maxLines: 1,
          controller: controller,
          textAlign: TextAlign.center,
          focusNode: focusNode,
          onChanged: (value) {
            setState(() {});
            if (value.length == 1) {
              focusNode.unfocus();
              FocusScope.of(context).requestFocus(nextFocusNode);
            }
          },
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
          style: const TextStyle(
            fontFamily: 'Golos Text',
            fontWeight: FontWeight.w400,
            fontSize: 28,
            color: Color.fromRGBO(31, 31, 44, 1),
          ),
        ),
        Container(
          height: 2,
          decoration: BoxDecoration(
            gradient: hasText || !isEmptyAndFocused
                ? const LinearGradient(
                    colors: [
                      Color.fromRGBO(108, 242, 254, 1),
                      Color.fromRGBO(41, 54, 255, 1),
                      Color.fromRGBO(254, 45, 183, 1),
                    ],
                  )
                : null,
            color: isEmptyAndFocused
                ? const Color.fromRGBO(216, 216, 220, 1)
                : null,
          ),
        ),
      ],
    );
  }
}
