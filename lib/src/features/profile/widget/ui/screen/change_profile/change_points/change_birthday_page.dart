import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChangeBirthdayPage extends StatelessWidget {
  const ChangeBirthdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('change birthday')),
    );
  }
}
