import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

Widget lowerButtom(
  String title,
  BuildContext context,
  dynamic route,
  String buttomTitle,
) {
  return Column(
    children: [
      Row(
        children: [
          const Expanded(
            child: Divider(
              endIndent: 15,
              height: 1,
              color: Color.fromRGBO(216, 216, 220, 1),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Golos Text',
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Color.fromRGBO(118, 118, 140, 1),
            ),
          ),
          const Expanded(
            child: Divider(
              indent: 15,
              height: 1,
              color: Color.fromRGBO(216, 216, 220, 1),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      GestureDetector(
        onTap: () {
          AutoRouter.of(context).push(
            route,
          );
        },
        child: Text(
          buttomTitle,
          style: const TextStyle(
            fontFamily: 'Golos Text',
            fontWeight: FontWeight.w600,
            fontSize: 19,
            color: Color.fromRGBO(24, 119, 242, 1),
          ),
        ),
      ),
      const SizedBox(
        height: 60,
      ),
    ],
  );
}
