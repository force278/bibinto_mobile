import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/features/addPost/bloc/add_post_bloc.dart';
import 'package:bibinto/src/features/addPost/data/add_post_repository.dart';
import 'package:bibinto/src/features/addPost/widget/ui/screen/add_post_screen.dart';
import 'package:bibinto/src/features/main/data/main_repository.dart';
import 'package:bibinto/src/features/main/modifire_bottom_navigation_bar.dart';
import 'package:bibinto/src/features/notifications/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MainPageLayout extends StatefulWidget {
  const MainPageLayout({super.key});

  @override
  State<MainPageLayout> createState() => _MainPageLayoutState();
}

class _MainPageLayoutState extends State<MainPageLayout> {
  final MainRepository _mainRepository = MainRepository();
  bool hasUnreadNotifications = false;
  final addPostRepository = AddPostRepository();
  final Map<int, GlobalKey> _pageKeys = {
    0: GlobalKey(),
    1: GlobalKey(),
    2: GlobalKey(),
    3: GlobalKey(),
    4: GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _checkUnreadNotifications();
  }

  void _checkUnreadNotifications() async {
    List<NotificationModel>? result = await _mainRepository.seeNotifications();

    if (result != null && result.isNotEmpty) {
      bool hasUnread = result.any((notification) =>
          (notification.like != null &&
              notification.like!.read != null &&
              !notification.like!.read!) ||
          (notification.comment != null &&
              notification.comment!.read != null &&
              !notification.comment!.read!) ||
          (notification.sub != null &&
              notification.sub!.read != null &&
              !notification.sub!.read!));

      if (hasUnread) {
        setState(() {
          hasUnreadNotifications = true;
        });
      }
    }
  }

  void _updateNotifications(QueryResult<Object?> result, int activeIndex) {
    if (result.data != null && activeIndex != 3) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          hasUnreadNotifications = true;
        });
      });
    }
  }

  void _onTabSelected(BuildContext context, int index) {
    if (index == 2) {
      showModalBottomSheet(
        barrierColor: Colors.black.withOpacity(0.5),
        context: context,
        isScrollControlled: true,
        builder: (context) => FractionallySizedBox(
          heightFactor: 0.9,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: BlocProvider(
              create: (context) => AddPostBloc(addPostRepository),
              child: const AddPostScreen(),
            ),
          ),
        ),
      );
    } else {
      setState(() {
        if (index == 3) {
          hasUnreadNotifications = false;
        }
        _pageKeys[index] = GlobalKey();
        AutoTabsRouter.of(context).setActiveIndex(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        GalleryRoute(),
        ChatsRoute(),
        AddPostRoute(),
        NotificationsRoute(),
        ProfileRoute(),
      ],
      inheritNavigatorObservers: false,
      duration: Duration.zero,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          key: _pageKeys[tabsRouter.activeIndex],
          body: Subscription(
            options: SubscriptionOptions(
              document: _mainRepository.notificationsSubscriprion,
            ),
            builder: (QueryResult<Object?> result) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }
              if (result.isLoading) {
                return child;
              }
              if (result.data != null && result.data!.isNotEmpty) {
                _updateNotifications(result, tabsRouter.activeIndex);
              }
              return child;
            },
          ),
          bottomNavigationBar: ModifiedBottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (value) => _onTabSelected(context, value),
            selectedItemBackgroundColor: Colors.transparent,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/gallery.svg',
                  height: 23,
                  width: 23,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/selected_gallery.svg',
                  height: 23,
                  width: 23,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/message.svg',
                  height: 23,
                  width: 23,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/selected_message.svg',
                  height: 23,
                  width: 23,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/addPublish.svg',
                  height: 55,
                  width: 55,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  hasUnreadNotifications
                      ? 'assets/icons/havenotification.svg'
                      : 'assets/icons/heart.svg',
                  height: 23,
                  width: 23,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/selected_notification.svg',
                  height: 23,
                  width: 23,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/profile.svg',
                  height: 23,
                  width: 23,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/selected_profile.svg',
                  height: 23,
                  width: 23,
                ),
                label: '',
              ),
            ],
          ),
        );
      },
    );
  }
}
