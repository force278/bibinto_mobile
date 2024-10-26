import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/features/main/main_page_layout.dart';
import 'package:flutter/widgets.dart';

@RoutePage<void>(name: 'MainFlowRouter')
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => const MainPageLayout();
}
