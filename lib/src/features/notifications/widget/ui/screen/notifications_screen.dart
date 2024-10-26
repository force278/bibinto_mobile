import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/features/notifications/bloc/notifications_bloc.dart';
import 'package:bibinto/src/features/notifications/model/notification_model.dart';
import 'package:bibinto/src/features/notifications/widget/ui/screen/notifications_layout.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<NotificationModel>? notifications;
    return Scaffold(
      appBar: CustomAppBar(
        title: Localized.of(context).notifications,
      ),
      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NotificationsLoaded) {
            notifications = state.notifications;
            return NotificationLayout(
              notifications: state.notifications ?? [],
            );
          } else if (state is NotificationsFailure) {
            return const Center(
              child: Text('Произошла ошибка'),
            );
          } else {
            return NotificationLayout(
              notifications: notifications ?? [],
            );
          }
        },
      ),
    );
  }
}
