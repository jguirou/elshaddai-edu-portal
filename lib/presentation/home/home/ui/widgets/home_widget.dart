import 'package:flutter/material.dart';

import '../../../../../utils/constants/texts.dart';
import 'home_content.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key, required this.sideMenu});
  final SideMenuController sideMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: HomeContent(
          onTapped: (title) {
            title.toString() == AppTexts.students
                ? sideMenu.changePage(1)
                : title.toString() == AppTexts.teacher
                ? sideMenu.changePage(2)
                : title.toString() == AppTexts.subscription
                ? sideMenu.changePage(3)
                : null;
          },
        ),
      ),
    );
  }
}
