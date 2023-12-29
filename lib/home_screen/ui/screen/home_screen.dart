import 'package:el_shaddai_edu_portal/home_screen/ui/widgets/home_content.dart';
import 'package:el_shaddai_edu_portal/students_screen/ui/screen/students_screen.dart';
import 'package:el_shaddai_edu_portal/themes/colors.dart';
import 'package:el_shaddai_edu_portal/utils/app_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

import '../../../add_students_screen/ui/screen/add_students_screen.dart';
import '../../../add_teachers_screen/ui/screen/add_teachers_screen.dart';
import '../../../teachers_screen/ui/screen/teachers_screen.dart';
import '../widgets/registration_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Sacramento-Regular',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              // showTooltip: false,
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: AppColors.hoverColor,
              selectedHoverColor: AppColors.hoverColor,
              selectedColor: AppColors.selectedColor,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              // backgroundColor: Colors.blueGrey[700]
            ),
            title: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 150,
                    maxWidth: 150,
                  ),
                  child: Image.asset(
                    'assets/images/school.png',
                  ),
                ),
                const Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.hoverColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Text(
                    'Version 0.0.1',
                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  ),
                ),
              ),
            ),
            items: [
              SideMenuItem(
                title: 'Home',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.home),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Élèves',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.person),
              ),
              SideMenuItem(
                title: 'Enseignants',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.person_3),
                trailing: Container(
                    decoration: const BoxDecoration(
                        color: AppColors.tableColor,
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 3),
                      child: Text(
                        'New',
                        style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                      ),
                    )),
              ),
              SideMenuItem(
                title: 'Inscription',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.person_add),
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
                title: 'À propos',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.settings),
              ),

              SideMenuItem(
                title: 'Se deconnecter',
                icon: Icon(Icons.exit_to_app),
                onTap: (index, _) {
                  /// goto signout
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Se deconnecter"),
                        content: Text("Êtes-vous sûr de vous deconnecter?"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('NON'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushNamed(
                                  context, "/login"); // Close the dialog
                            },
                            child: Text('OUI'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                /// Home
                Container(
                  color: Colors.white,
                  child: Center(
                    child: HomeContent(
                      onTapped: (title) {
                        title.toString() == 'Élèves'
                            ? sideMenu.changePage(1)
                            : title.toString() == 'Enseignants'
                                ? sideMenu.changePage(2)
                                : title.toString() == 'Inscription'
                                    ? sideMenu.changePage(3)
                                    : null;
                      },
                    ),
                  ),
                ),

                /// Students
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: StudentsScreen(),
                  ),
                ),

                /// Teacher
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: TeachersScreen(),
                  ),
                ),

                /// Registration
                Container(
                  color: Colors.white,
                  child: Center(child: RegistrationContent(
                    onTapped: (index) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 350.0, right: 350.0, bottom: 0, top: 0),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: AlertDialog(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        35.0), // Adjust the radius to control the corner rounding
                                  ),
                                ),
                                title: index == 0
                                    ? const Text(
                                        "Inscrire un élève",
                                        textAlign: TextAlign.center,
                                      )
                                    : const Text(
                                        "Inscrire un enseignant",
                                        textAlign: TextAlign.center,
                                      ),
                                content: index == 0
                                    ? Container(
                                        color: Colors.transparent,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8, // Fixed width
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.6,
                                        child: AddStudentsScreen(
                                            onCancelClicked: () {
                                          Navigator.pop(context);
                                        }, onAddClicked: () {
                                              AppUtils.showSnackBar(context, " l'élève a été inscrit");
                                          Navigator.pop(context);
                                        }))
                                    : Container(
                                        color: Colors.transparent,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8, // Fixed width
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.6,
                                        child: AddTeachersScreen(
                                            onCancelClicked: () {
                                          Navigator.pop(context);
                                        }, onAddClicked: () {
                                          AppUtils.showSnackBar(context, " l'enseignant a été inscrit");

                                          Navigator.pop(context);
                                        }),
                                      ),
                              ),
                            ),
                          );
                        },
                      );
                      //index == 0 ? sideMenu.changePage(5): sideMenu.changePage(6);
                    },
                  )),
                ),

                /// About
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Coming soon ...',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}