import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:flutter/material.dart';

Widget profilePhotoAndName(
  UserModel user,
) {
  return Center(
    child: Column(
      children: [
        ClipOval(
          child: user.avatar != null
              ? ClipOval(
                  child: Image.network(
                    user.avatar ?? '',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  color: const Color.fromRGBO(216, 216, 220, 1),
                  child: const Icon(
                    Icons.person,
                    size: 90,
                    color: Color.fromRGBO(174, 174, 178, 1),
                  ),
                ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '${user.firstName} ${user.lastName}',
          style: const TextStyle(
            fontFamily: 'Golos Text',
            fontWeight: FontWeight.w600,
            fontSize: 19,
            color: Color.fromRGBO(31, 31, 44, 1),
          ),
        ),
      ],
    ),
  );
}
