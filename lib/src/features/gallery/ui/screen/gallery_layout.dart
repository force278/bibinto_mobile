import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/features/gallery/ui/screen/posts/rec/recommendations_screen.dart';

import 'package:bibinto/src/features/gallery/ui/screen/posts/sub/subscription_screen.dart';
import 'package:flutter/material.dart';

class GalleryLayout extends StatefulWidget {
  const GalleryLayout({super.key});

  @override
  State<GalleryLayout> createState() => _GalleryLayoutState();
}

class _GalleryLayoutState extends State<GalleryLayout> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: 22,
            width: 77,
          ),
        ),
      ),
      body: Column(
        children: [
          selectedButton(),
          !isSelected
              ? const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    child: RecommendationsScreen(),
                  ),
                )
              : const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    child: SubscriptionScreen(),
                  ),
                ),
        ],
      ),
    );
  }

  Widget selectedButton() {
    TextStyle selected = const TextStyle(
      fontFamily: 'Golos Text',
      fontWeight: FontWeight.w500,
      fontSize: 17,
      color: Color.fromRGBO(31, 31, 44, 1),
    );

    TextStyle notSelected = const TextStyle(
      fontFamily: 'Golos Text',
      fontWeight: FontWeight.w500,
      fontSize: 17,
      color: Color.fromRGBO(118, 118, 140, 1),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              isSelected = true;
            });
          },
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: Text(
            Localized.of(context).subscriptions,
            style: isSelected ? selected : notSelected,
          ),
        ),
        const SizedBox(
          height: 11,
          child: VerticalDivider(
            color: Color.fromRGBO(216, 216, 220, 1),
            width: 5,
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              isSelected = false;
            });
          },
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: Text(
            Localized.of(context).recommendations,
            style: isSelected ? notSelected : selected,
          ),
        ),
      ],
    );
  }
}
