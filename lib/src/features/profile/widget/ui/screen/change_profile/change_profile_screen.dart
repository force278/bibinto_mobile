import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/features/auth/data/user_data.dart';
import 'package:bibinto/src/features/profile/bloc/profile_bloc.dart';
import 'package:bibinto/src/features/profile/data/repository/profile_repository.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class ChangeProfileScreen extends StatefulWidget {
  const ChangeProfileScreen({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<ChangeProfileScreen> createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController nickNameController;
  late TextEditingController bioController;
  String? avatarUrl;

  @override
  void initState() {
    super.initState();
    avatarUrl = widget.user.avatar;
    firstNameController = TextEditingController(text: widget.user.firstName);
    lastNameController = TextEditingController(text: widget.user.lastName);
    nickNameController = TextEditingController(text: widget.user.username);
    bioController = TextEditingController(text: widget.user.bio);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    nickNameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        action: _doneButton(context),
        title: Localized.of(context).changeProfile,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                AutoRouter.of(context).replace(const ProfileRoute());
              },
              child: SvgPicture.asset(
                'assets/icons/back.svg',
                height: 36,
                width: 36,
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: _body(context),
      ),
    );
  }

  Widget _doneButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        BlocProvider.of<ProfileBloc>(context).add(
          EditProfileEvent(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            username: nickNameController.text,
            bio: bioController.text,
          ),
        );
        AutoRouter.of(context).replace(const ProfileRoute());
      },
      child: Text(
        Localized.of(context).done,
        style:
            _textStyle.copyWith(color: const Color.fromRGBO(24, 119, 242, 1)),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            _avatarAndButton(context),
            const SizedBox(height: 20),
            _info(context),
          ],
        ),
      ),
    );
  }

  Widget _avatarAndButton(BuildContext context) {
    final profileRepository = ProfileRepository();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipOval(
          child: widget.user.avatar != null
              ? Image.network(avatarUrl ?? '',
                  width: 110, height: 110, fit: BoxFit.cover)
              : const Icon(Icons.person,
                  size: 90, color: Color.fromRGBO(174, 174, 178, 1)),
        ),
        TextButton(
          onPressed: () async {
            final imageFiles = await profileRepository.loadImages();
            if (imageFiles.isNotEmpty) {
              final selectedImage = imageFiles.first;
              final croppedImage =
                  await profileRepository.cropImage(selectedImage);
              final newImage =
                  await profileRepository.uploadPhoto(croppedImage!);
              UserData().avatar = newImage;
              setState(() => avatarUrl = newImage);
            }
          },
          child: Text(
            Localized.of(context).changeAvatar,
            style: _textStyle.copyWith(
              color: const Color.fromRGBO(24, 119, 242, 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _info(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromRGBO(242, 242, 247, 1),
          ),
          bottom: BorderSide(
            color: Color.fromRGBO(242, 242, 247, 1),
          ),
        ),
      ),
      child: Column(
        children: [
          rowForInfo(
            controller: firstNameController,
            label: Localized.of(context).firstName,
            isDivider: true,
          ),
          rowForInfo(
            controller: lastNameController,
            label: Localized.of(context).lastName,
            isDivider: true,
          ),
          rowForInfo(
            controller: nickNameController,
            label: Localized.of(context).nickName,
            isDivider: true,
          ),
          rowForInfo(
            controller: bioController,
            label: Localized.of(context).bio,
            isDivider: false,
          ),
        ],
      ),
    );
  }

  Widget rowForInfo({
    required String label,
    required TextEditingController controller,
    bool? isDivider,
  }) {
    const labelTextStyle = TextStyle(
      fontFamily: 'Golos Text',
      fontWeight: FontWeight.w400,
      fontSize: 15,
      color: Color.fromRGBO(174, 174, 178, 1),
    );

    const textStyle = TextStyle(
      fontFamily: 'Golos Text',
      fontWeight: FontWeight.w400,
      fontSize: 17,
      color: Color.fromRGBO(31, 31, 44, 1),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            width: 80,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: labelTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDivider ?? false
                        ? const Color.fromRGBO(242, 242, 247, 1)
                        : Colors.transparent,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  alignment: Alignment.center,
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: textStyle,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final TextStyle _textStyle = const TextStyle(
    fontFamily: 'Golos Text',
    fontWeight: FontWeight.w500,
    fontSize: 17,
    color: Color.fromRGBO(31, 31, 44, 1),
  );
}
