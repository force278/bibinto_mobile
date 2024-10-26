import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.action,
    this.title,
    this.leading,
  });

  final Widget? action;
  final String? title;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 70,
      leadingWidth: 70,
      actions: [action ?? const SizedBox()],
      leading: leading,
      title: Text(
        title ?? '',
        style: const TextStyle(
          fontFamily: 'Golos Text',
          fontWeight: FontWeight.w500,
          fontSize: 19,
          color: Color.fromRGBO(31, 31, 44, 1),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: const Color.fromRGBO(242, 242, 247, 1),
          height: 1.0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
