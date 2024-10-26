import 'package:flutter/material.dart';

void showCustomErrorNotification(
  BuildContext context,
  String title,
  String description,
) {
  OverlayState? overlayState = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => CustomErrorNotification(
      title: title,
      description: description,
      onDismissed: () => overlayEntry.remove(),
    ),
  );

  overlayState.insert(overlayEntry);
}

class CustomErrorNotification extends StatefulWidget {
  final String title;
  final String description;
  final VoidCallback onDismissed;

  const CustomErrorNotification({
    super.key,
    required this.title,
    required this.description,
    required this.onDismissed,
  });

  @override
  CustomErrorNotificationState createState() => CustomErrorNotificationState();
}

class CustomErrorNotificationState extends State<CustomErrorNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();

    Future.delayed(const Duration(seconds: 3)).then((_) {
      _animationController.reverse().then((_) => widget.onDismissed());
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFC72C41),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontFamily: 'Golos Text',
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.description,
                          style: const TextStyle(
                            fontFamily: 'Golos Text',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          maxLines: null,
                          overflow: TextOverflow.visible,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
