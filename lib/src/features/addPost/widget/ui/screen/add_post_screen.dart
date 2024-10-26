import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/common/domain/local_storage.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/features/addPost/bloc/add_post_bloc.dart';
import 'package:bibinto/src/features/addPost/data/add_post_repository.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController descriptionController = TextEditingController();
  final addPostRepository = AddPostRepository();
  String? postUrl;

  @override
  void initState() {
    super.initState();
    addPostURL();
  }

  void addPostURL() async {
    final imageFiles = await addPostRepository.loadImages();
    if (imageFiles.isNotEmpty) {
      final selectedImage = imageFiles.first;
      final croppedImage = await addPostRepository.cropImage(selectedImage);
      if (croppedImage != null) {
        final newImage = await addPostRepository.uploadPhoto(croppedImage);
        setState(() => postUrl = newImage);
      } else {
        // Handle the case where cropping fails
        Navigator.pop(context);
      }
    } else {
      // Handle the case where no images are loaded
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localStorage = LocalStorage();
    final avatar = localStorage.avatar;
    final username = localStorage.userName;
    const EdgeInsets postPadding = EdgeInsets.only(
      left: 10,
      right: 20,
    );
    return postUrl == null
        ? Container()
        : Scaffold(
            appBar: CustomAppBar(
              action: _doneButton(
                context: context,
                postUrl: postUrl ?? '',
                caption: descriptionController,
              ),
              title: Localized.of(context).addPublish,
            ),
            body: postUrl == null
                ? Container()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: postPadding,
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      color: const Color.fromRGBO(
                                          216, 216, 220, 1),
                                      child: Image.network(
                                        avatar ?? '',
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    username ?? '',
                                    style: const TextStyle(
                                      fontFamily: 'Golos Text',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Color.fromRGBO(31, 31, 44, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: postUrl != null
                              ? Image.network(
                                  postUrl ?? '',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Container(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              label: Text(
                                'введите описание',
                                style: TextStyle(
                                  fontFamily: 'Golos Text',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                  color: Color.fromRGBO(31, 31, 44, 1),
                                ),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(
                                fontFamily: 'Golos Text',
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                color: Color.fromRGBO(31, 31, 44, 1),
                              ),
                              border: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
  }
}

Widget _doneButton({
  required BuildContext context,
  required String postUrl,
  TextEditingController? caption,
}) {
  return TextButton(
    onPressed: () {
      BlocProvider.of<AddPostBloc>(context).add(
        PublishPhotoEvent(postUrl, caption?.text ?? ''),
      );
      Navigator.pop(context);

      /// TO-DO: Реализовать переход на галерею
    },
    child: Text(
      Localized.of(context).done,
      style: const TextStyle(
        fontFamily: 'Golos Text',
        fontWeight: FontWeight.w500,
        fontSize: 17,
        color: Color.fromRGBO(24, 119, 242, 1),
      ),
    ),
  );
}
