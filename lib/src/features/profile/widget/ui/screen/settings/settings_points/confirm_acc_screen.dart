import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/back_button.dart';
import 'package:bibinto/src/features/profile/bloc/profile_bloc.dart';
import 'package:bibinto/src/features/profile/data/repository/profile_repository.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/widgets/custom_app_bar.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/settings/settings_points/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ConfirmAccScreen extends StatefulWidget {
  const ConfirmAccScreen({super.key});

  @override
  State<ConfirmAccScreen> createState() => _ConfirmAccScreenState();
}

class _ConfirmAccScreenState extends State<ConfirmAccScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String? _photoConfirmID;

  bool isDisable = true;

  @override
  void initState() {
    usernameController.addListener(_updateDisableState);
    nameController.addListener(_updateDisableState);
    super.initState();
  }

  void _updateDisableState() {
    setState(() {
      isDisable = usernameController.text.isEmpty ||
          nameController.text.isEmpty ||
          _photoConfirmID == null;
    });
  }

  @override
  void dispose() {
    usernameController.removeListener(_updateDisableState);
    nameController.removeListener(_updateDisableState);
    usernameController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileRepository = ProfileRepository();

    const textStyle = TextStyle(
      fontFamily: 'Golos Text',
      fontWeight: FontWeight.w400,
      fontSize: 17,
      color: Color.fromRGBO(31, 31, 44, 1),
    );

    const upperLabelStyle = TextStyle(
      fontFamily: 'Golos Text',
      fontWeight: FontWeight.w400,
      fontSize: 15,
      color: Color.fromRGBO(118, 118, 140, 1),
    );

    return Scaffold(
      appBar: CustomAppBar(
        action: TextButton(
          onPressed: () {
            if (isDisable) {
              print('disabled');
            } else {
              if (_photoConfirmID != null) {
                BlocProvider.of<ProfileBloc>(context).add(
                  OfficialRequestEvent(_photoConfirmID as String),
                );
              }
              Navigator.of(context).pop();
            }
          },
          child: Text(
            Localized.of(context).done,
            style: TextStyle(
              fontFamily: 'Golos Text',
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: isDisable
                  ? const Color.fromRGBO(174, 174, 178, 1)
                  : const Color.fromRGBO(24, 119, 242, 1),
            ),
          ),
        ),
        title: Localized.of(context).confirmAcc,
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
              Text(
                Localized.of(context).confirmAccDescription,
                style: textStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Localized.of(context).nickName,
                  style: upperLabelStyle,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              textField(
                context: context,
                controller: usernameController,
                textStyle: textStyle,
                label: Localized.of(context).enterNickname,
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Localized.of(context).firstName,
                  style: upperLabelStyle,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              textField(
                context: context,
                controller: nameController,
                textStyle: textStyle,
                label: Localized.of(context).enterFirstName,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Divider(
                  color: Color.fromRGBO(242, 242, 247, 1),
                  height: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      _photoConfirmID != null
                          ? Localized.of(context).fileIsSelected
                          : Localized.of(context).addPhotoIdCard,
                      style: upperLabelStyle,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_photoConfirmID != null) {
                        setState(() => _photoConfirmID = null);
                      } else {
                        final imageFiles = await profileRepository.loadImages();
                        if (imageFiles.isNotEmpty) {
                          File? selectedImage = imageFiles.first;
                          final newImage = await profileRepository
                              .uploadPhoto(selectedImage);
                          setState(() => _photoConfirmID = newImage);
                        } else {
                          print("Выбор файла отменен");
                        }
                      }
                    },
                    child: Text(
                      _photoConfirmID != null
                          ? Localized.of(context).deleteFile
                          : Localized.of(context).selectFile,
                      style: upperLabelStyle.copyWith(
                        color: const Color.fromRGBO(24, 119, 242, 1),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
