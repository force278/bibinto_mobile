import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/back_button.dart';
import 'package:bibinto/src/common/widgets/custom_linear_button.dart';
import 'package:bibinto/src/common/widgets/utils.dart';
import 'package:bibinto/src/features/auth/bloc/auth_bloc.dart';
import 'package:bibinto/src/features/auth/data/repository/image_repository/image_repository.dart';
import 'package:bibinto/src/features/auth/data/user_data.dart';
import 'package:bibinto/src/features/auth/model/user_registr_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AddPhotoProfileScreen extends StatefulWidget {
  const AddPhotoProfileScreen({super.key});

  @override
  State<AddPhotoProfileScreen> createState() => _AddPhotoProfileScreenState();
}

class _AddPhotoProfileScreenState extends State<AddPhotoProfileScreen> {
  final imageRepository = ImageRepository();
  bool isEmpty = true;
  String? _selectedImage;

  void compliteRegistration() {
    if (_selectedImage != null &&
        UserData().firstName != null &&
        UserData().lastName != null &&
        UserData().nickName != null &&
        UserData().userEmail != null &&
        UserData().password != null &&
        UserData().gender != null &&
        UserData().bio != null) {
      final userModel = UserRegistrModel(
        firstName: UserData().firstName!,
        lastName: UserData().lastName!,
        username: UserData().nickName!,
        email: UserData().userEmail!,
        password: UserData().password!,
        gender: UserData().gender!,
        avatar: _selectedImage!,
        bio: UserData().bio!,
      );
      BlocProvider.of<AuthBloc>(context).add(CreateAccountStarted(
        firstName: userModel.firstName ?? '',
        lastName: userModel.lastName ?? '',
        username: userModel.username ?? '',
        email: userModel.email ?? '',
        password: userModel.password ?? '',
        gender: userModel.gender ?? 0,
        avatar: userModel.avatar ?? '',
        bio: userModel.bio ?? '',
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is CreateAccountSuccess) {
          AutoRouter.of(context).push(const MainFlowRouter());
        } else if (state is CreateAccountFailure) {
          print(state.error.toString());
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
                children: [
                  backButton(context),
                  const SizedBox(height: 90),
                  _buildCreatePhotoDescription(context),
                  const SizedBox(height: 30),
                  _buildSelectPhoto(),
                  const SizedBox(height: 30),
                  customLinearButton(
                    title: Localized.of(context).finishRegistr,
                    func: compliteRegistration,
                    isEnabled: isEmpty,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectPhoto() {
    return GestureDetector(
      onTap: () => Utils.showSheet(
        context,
        child: Text(
          Localized.of(context).changePhoto,
          style: const TextStyle(
            fontFamily: 'Golos Text',
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Color.fromRGBO(31, 31, 44, 1),
          ),
        ),
        func: () async {
          final imageFiles = await imageRepository.loadImages();
          if (imageFiles.isNotEmpty) {
            File? selectedImage = imageFiles.first;
            File? croppedImage = await imageRepository.cropImage(selectedImage);
            final newImage =
                await imageRepository.uploadPhoto(croppedImage ?? '' as File);
            UserData().avatar = newImage;
            setState(
              () {
                _selectedImage = newImage;
                isEmpty = false;
              },
            );
          }
        },
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(108, 242, 254, 1),
              Color.fromRGBO(41, 54, 255, 1),
              Color.fromRGBO(254, 45, 183, 1),
            ],
          ),
          shape: BoxShape.circle,
        ),
        width: 185,
        height: 185,
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            color: _selectedImage != null
                ? Colors.white
                : const Color.fromRGBO(242, 242, 247, 1),
            shape: BoxShape.circle,
          ),
          width: 180,
          height: 180,
          padding: const EdgeInsets.all(4),
          child: _selectedImage != null
              ? ClipOval(
                  child: Image.network(
                    _selectedImage!,
                    width: 173,
                    height: 173,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  'assets/images/camera.png',
                  height: 42,
                  width: 42,
                ),
        ),
      ),
    );
  }
}

Widget _buildCreatePhotoDescription(BuildContext context) {
  return Column(
    children: [
      Text(
        Localized.of(context).profilePhoto,
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
        Localized.of(context).addPhotoDescription,
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
