import 'package:flutter/material.dart';

Widget textField(
    {required BuildContext context,
    Widget? suffixIcon,
    required TextEditingController controller,
    bool obscureText = false,
    required TextStyle textStyle,
    required String label,
    bool? isPasswordValid = true,
    void Function(String)? onChanged,
    int maxLines = 1}) {
  return TextField(
    controller: controller,
    maxLines: maxLines,
    keyboardType: TextInputType.multiline,
    obscureText: obscureText,
    onChanged: onChanged,
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      label: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Golos Text',
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: Color.fromRGBO(174, 174, 178, 1),
        ),
      ),
      alignLabelWithHint: true,
      border: InputBorder.none,
      enabledBorder: OutlineInputBorder(
        borderSide: isPasswordValid ?? true
            ? BorderSide.none
            : const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: isPasswordValid ?? true
            ? BorderSide.none
            : const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: isPasswordValid ?? true
            ? BorderSide.none
            : const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorStyle: const TextStyle(fontSize: 0),
      contentPadding: const EdgeInsets.all(15),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: const Color.fromRGBO(242, 242, 247, 1),
      filled: true,
    ),
    style: textStyle,
  );
}
