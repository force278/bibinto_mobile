import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/widgets/error_notification.dart';
import 'package:bibinto/src/features/auth/data/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/back_button.dart';
import 'package:bibinto/src/common/widgets/custom_linear_button.dart';
import 'package:bibinto/src/common/widgets/custom_text_form_field.dart';
import 'package:bibinto/src/common/widgets/utils.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class BasicInformationScreen extends StatefulWidget {
  const BasicInformationScreen({super.key});

  @override
  State<BasicInformationScreen> createState() => _BasicInformationScreenState();
}

class _BasicInformationScreenState extends State<BasicInformationScreen> {
  DateTime dateTime = DateTime.now();
  int currentYear = DateTime.now().year;
  TextEditingController nicknameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  Map<String, int> genderMap = {};
  late int? currentOption;
  bool isEmpty = true;

  @override
  void initState() {
    super.initState();
    currentOption = genderMap.isNotEmpty ? genderMap.values.first : null;
    nicknameController.addListener(checkIfFormIsFilled);
    dateTimeController.addListener(checkIfFormIsFilled);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (genderMap.isEmpty) {
      genderMap = {
        Localized.of(context).male: 1,
        Localized.of(context).female: 2,
      };
    }
    checkIfFormIsFilled();
  }

  void checkIfFormIsFilled() {
    setState(() {
      isEmpty = firstNameController.text.isEmpty ||
          lastNameController.text.isEmpty ||
          nicknameController.text.isEmpty ||
          dateTimeController.text.isEmpty ||
          currentOption == null;
    });
  }

  void sendBasicInfo() async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        nicknameController.text.isEmpty ||
        dateTimeController.text.isEmpty ||
        currentOption == null) {
      // Handle empty fields
    } else {
      final firstName = firstNameController.text;
      final lastName = lastNameController.text;
      final nickname = nicknameController.text;
      final birthDate = dateTimeController.text;
      final bio = bioController.text;
      final gender = currentOption;

      if (gender != null) {
        UserData().firstName = firstName;
        UserData().lastName = lastName;
        UserData().nickName = nickname;
        UserData().birthDate = birthDate;
        UserData().gender = gender;
        UserData().bio = bio;
      }
      final isLatin = RegExp(r'^[a-zA-Z0-9.,!?]+$').hasMatch(nickname);
      if (!isLatin) {
        showCustomErrorNotification(
          context,
          'Ошибка',
          'Никнейм может содержать латинские символы цифры и знаки препинания.',
        );
        return;
      } else if (isLatin) {
        AutoRouter.of(context).push(const AddPhotoProfileRoute());
      }
    }
  }

  @override
  void dispose() {
    nicknameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    bioController.dispose();
    dateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            toolbarHeight: 100,
            leadingWidth: 70,
            leading: Padding(
              padding: const EdgeInsets.only(
                left: 35,
                top: 30,
              ),
              child: backButton(context),
            )),
        body: Listener(
          onPointerDown: (_) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: 35,
              right: 35,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildBasicInfoTitle(context),
                  const SizedBox(height: 30),
                  customTextFormField(
                    Localized.of(context).firstName,
                    Localized.of(context).enterFirstName,
                    firstNameController,
                    null,
                  ),
                  const SizedBox(height: 30),
                  customTextFormField(
                    Localized.of(context).lastName,
                    Localized.of(context).enterLastName,
                    lastNameController,
                    null,
                  ),
                  const SizedBox(height: 30),
                  customTextFormField(
                    Localized.of(context).nickName,
                    Localized.of(context).enterNickname,
                    nicknameController,
                    null,
                    forceLowerCase: true,
                  ),
                  const SizedBox(height: 30),
                  _buildDatePicker(context),
                  const SizedBox(height: 30),
                  customTextFormField(
                    Localized.of(context).bio,
                    Localized.of(context).enterBio,
                    bioController,
                    null,
                  ),
                  const SizedBox(height: 20),
                  _buildGenderTitle(context),
                  _buildGenderOptions(),
                  customLinearButton(
                    title: Localized.of(context).registration,
                    func: sendBasicInfo,
                    isEnabled: isEmpty,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfoTitle(BuildContext context) {
    return Text(
      Localized.of(context).basicInfo,
      style: const TextStyle(
        fontFamily: 'Golos Text',
        fontWeight: FontWeight.w500,
        fontSize: 24,
        color: Color.fromRGBO(31, 31, 44, 1),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.showCustomModalBottomSheet(
        context,
        child: SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            minimumYear: 1900,
            maximumYear: currentYear,
            initialDateTime: dateTime,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (dateTime) => setState(() {
              this.dateTime = dateTime;
              checkIfFormIsFilled();
            }),
          ),
        ),
        onClicked: () {
          final value = DateFormat('dd.MM.yyyy').format(dateTime);
          dateTimeController.text = value;
          Navigator.of(context).pop();
        },
      ),
      child: customTextFormField(
        Localized.of(context).birthDay,
        Localized.of(context).selectDate,
        dateTimeController,
        null,
        disabled: true,
      ),
    );
  }

  Widget _buildGenderTitle(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        Localized.of(context).gender,
        style: const TextStyle(
          fontFamily: 'Golos Text',
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: Color.fromRGBO(118, 118, 140, 1),
        ),
      ),
    );
  }

  Widget _buildGenderOptions() {
    var genderOptions = genderMap.keys.toList();
    return Row(
      children:
          genderOptions.map((option) => _buildGenderOption(option)).toList(),
    );
  }

  Widget _buildGenderOption(String genderOption) {
    return Expanded(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Transform.translate(
          offset: const Offset(-35, -10),
          child: Text(
            genderOption == Localized.of(context).male
                ? Localized.of(context).male
                : Localized.of(context).female,
            style: const TextStyle(
              fontFamily: 'Golos Text',
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Color.fromRGBO(31, 31, 44, 1),
            ),
          ),
        ),
        leading: Transform.translate(
          offset: const Offset(-16, -10),
          child: Radio<int>(
            activeColor: const Color.fromRGBO(24, 119, 242, 1),
            fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return const Color.fromRGBO(24, 119, 242, 1);
              }
              return const Color.fromRGBO(216, 216, 220, 1);
            }),
            value: genderMap[genderOption] ?? 0,
            groupValue: currentOption,
            onChanged: (int? value) {
              setState(() {
                currentOption = value;
                checkIfFormIsFilled();
              });
            },
          ),
        ),
      ),
    );
  }
}
