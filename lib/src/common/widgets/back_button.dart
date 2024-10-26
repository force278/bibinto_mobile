import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget backButton(BuildContext context) {
  return Align(
    alignment: Alignment.topLeft,
    child: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
      },
      child: SvgPicture.asset(
        'assets/icons/back.svg',
        height: 36,
        width: 36,
      ),
    ),
  );
}
