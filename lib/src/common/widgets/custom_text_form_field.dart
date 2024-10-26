import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget customTextFormField(
  String? title,
  String label,
  TextEditingController controller,
  String? Function(String?)? validator, {
  bool obscureText = false,
  void Function(String)? onChanged,
  Widget? suffixIcon,
  bool? isPasswordValid = true,
  bool disabled = false,
  bool forceUpperCase = false,
  bool forceLowerCase = false,
  TextInputType? keyboardType,
}) {
  final upperCaseFormatter =
      TextInputFormatter.withFunction((oldValue, newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  });

  final lowerCaseFormatter =
      TextInputFormatter.withFunction((oldValue, newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  });

  List<TextInputFormatter> inputFormatters = [];
  if (forceUpperCase) {
    inputFormatters.add(upperCaseFormatter);
  } else if (forceLowerCase) {
    inputFormatters.add(lowerCaseFormatter);
    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"));
  }

  return Column(
    children: [
      if (title != null)
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Golos Text',
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Color.fromRGBO(118, 118, 140, 1),
            ),
          ),
        ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        onChanged: onChanged,
        enabled: !disabled,
        inputFormatters: inputFormatters,
        style: const TextStyle(
          fontFamily: 'Golos Text',
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: Color.fromRGBO(31, 31, 44, 1),
        ),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
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
          labelText: label,
          labelStyle: const TextStyle(
            fontFamily: 'Golos Text',
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Color.fromRGBO(174, 174, 178, 1),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: const Color.fromRGBO(242, 242, 247, 1),
          filled: true,
        ),
      ),
    ],
  );
}
