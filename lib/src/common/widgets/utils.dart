import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static List<Widget> modelBuilder<M>(
          List<M> models, Widget Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();

  static void showSheet(
    BuildContext context, {
    required Widget child,
    required Function() func,
    VoidCallback? onClicked,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                func();
              },
              child: child,
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              Localized.of(context).cancel,
              style: const TextStyle(
                fontFamily: 'Golos Text',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Color.fromRGBO(24, 119, 242, 1),
              ),
            ),
          ),
        ),
      );

  static void showDoubleButtonSheet(
    BuildContext context, {
    Widget? firstButton,
    Widget? secondButton,
    Function()? firstFunc,
    Function()? secondFunc,
    VoidCallback? onClicked,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) {
          List<Widget> actions = [];

          if (firstButton != null) {
            actions.add(
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (firstFunc != null) {
                    firstFunc();
                  }
                },
                child: firstButton,
              ),
            );
          }

          if (secondButton != null) {
            actions.add(
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (secondFunc != null) {
                    secondFunc();
                  }
                },
                child: secondButton,
              ),
            );
          }

          return CupertinoActionSheet(
            actions: actions,
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                Localized.of(context).cancel,
                style: const TextStyle(
                  fontFamily: 'Golos Text',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Color.fromRGBO(24, 119, 242, 1),
                ),
              ),
            ),
          );
        },
      );

  static void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 24)),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  // Добавленный метод
  static void showCustomModalBottomSheet(
    BuildContext context, {
    required Widget child,
    required VoidCallback onClicked,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 40,
                  top: 20,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: onClicked,
                    child: const Text(
                      'Готово',
                      style: TextStyle(
                        fontFamily: 'Golos Text',
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Color.fromRGBO(24, 119, 242, 1),
                      ),
                    ),
                  ),
                ),
              ),
              child,
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}
