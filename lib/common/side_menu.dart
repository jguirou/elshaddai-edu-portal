import 'package:el_shaddai_edu_portal/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/image_strings.dart';
import '../utils/constants/routes.dart';
import '../utils/constants/texts.dart';

class MySideMenu extends StatelessWidget {
  const MySideMenu({
    super.key,
    required this.sideMenu,
  });

  final SideMenuController sideMenu;

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      controller: sideMenu,
      style: SideMenuStyle(
        // showTooltip: false,
        displayMode: SideMenuDisplayMode.auto,
        hoverColor: AppColors.hoverColor,
        selectedHoverColor: AppColors.hoverColor,
        selectedColor: Colors.blue,
        selectedTitleTextStyle: const TextStyle(color: Colors.white),
        unselectedTitleTextStyle: Theme.of(context).textTheme.bodyLarge,
        selectedIconColor: Colors.white,
      ),
      title: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 150,
              maxWidth: 150,
            ),
            child: Image.asset(
              AppImages.school,
            ),
          ),
          const Divider(
            indent: 8.0,
            endIndent: 8.0,
          ),
        ],
      ),
      items: [
        SideMenuItem(
          title: AppTexts.home,
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          icon: const Icon(Icons.home),
          tooltipContent: AppTexts.home,
        ),
        SideMenuItem(
          title: AppTexts.students,
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          icon: const Icon(Icons.person),
        ),
        SideMenuItem(
          title: AppTexts.teacher,
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          icon: const Icon(Icons.person_3),
          trailing: Container(
              decoration: const BoxDecoration(
                //color: AppColors.tableColor,
                  borderRadius: BorderRadius.all(Radius.circular(AppSizes.sm))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6.0, vertical: 3),
                child: Text(
                  AppTexts.newest,
                  style: Theme.of(context).textTheme.labelMedium!.apply(color: Colors.orange),
                ),
              )),
        ),
        SideMenuItem(
          title: AppTexts.registration,
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          icon: const Icon(Icons.person_add),
        ),
        SideMenuItem(
          title: AppTexts.schoolFee,
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          icon: const Icon(Icons.monetization_on),
        ),
        SideMenuItem(
          title: AppTexts.classes,
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          icon: const Icon(Icons.class_),
        ),
        SideMenuItem(
          builder: (context, displayMode) {
            return const Divider(
              endIndent: 8,
              indent: 8,
            );
          },
        ),
        SideMenuItem(
          title: AppTexts.about,
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          icon: const Icon(Icons.settings),
        ),
        SideMenuItem(
          title: AppTexts.logout,
          icon: const Icon(Icons.exit_to_app),
          onTap: (index, _) {
            /// goto signout
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(AppTexts.logout),
                  content:
                   const Text(AppTexts.logoutDescription),
                  actions: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text(AppTexts.no),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(
                            context, Routes.login); // Close the dialog
                      },
                      child:  const Text(AppTexts.yes),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}