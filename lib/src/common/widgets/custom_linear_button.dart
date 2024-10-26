import 'package:flutter/material.dart';

Widget customLinearButton({
  String? title,
  VoidCallback? func,
  bool isEnabled = false,
  Color? buttonColor,
  Widget? icon,
  TextStyle? textStyle,
}) {
  return SizedBox(
    child: ElevatedButton(
      onPressed: func,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          buttonColor ??
              (isEnabled ? const Color.fromRGBO(216, 216, 220, 1) : null),
        ),
        elevation: MaterialStateProperty.all(0),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: isEnabled
              ? LinearGradient(
                  colors: [
                    buttonColor ?? const Color.fromRGBO(216, 216, 220, 1),
                    buttonColor ?? const Color.fromRGBO(216, 216, 220, 1),
                  ],
                )
              : const LinearGradient(
                  colors: [
                    Color.fromRGBO(108, 242, 254, 1),
                    Color.fromRGBO(41, 54, 255, 1),
                    Color.fromRGBO(254, 45, 183, 1),
                  ],
                ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                icon,
                const SizedBox(width: 8),
              ],
              Text(
                title ?? '',
                style: textStyle ??
                    const TextStyle(
                      fontFamily: 'Golos Text',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color.fromRGBO(225, 225, 225, 1),
                    ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
