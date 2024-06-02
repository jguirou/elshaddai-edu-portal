import 'package:el_shaddai_edu_portal/utils/helpers/helper_functions.dart';

import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

import '../../../../../common/side_menu.dart';
import '../../../../../utils/constants/fonts.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../registration/add_students/ui/screen/add_students_screen.dart';
import '../../../registration/add_teachers/ui/screen/add_teachers_screen.dart';
import '../../../school_fees/ui/screen/school_fees_screen.dart';
import '../../../students/ui/screen/students_screen.dart';
import '../../../teachers/ui/screen/teachers_screen.dart';
import '../widgets/home_widget.dart';
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
  late String classLevel;

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
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: Colors.white, fontFamily: AppFonts.sacramentoRegular),
        ),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MySideMenu(sideMenu: sideMenu),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                /// Home
                HomeWidget(sideMenu: sideMenu),

                /// Students
                const Center(
                  child: StudentsScreen(),
                ),

                /// Teacher
                const Center(
                  child: TeachersScreen(),
                ),

                /// Registration
                Center(child: RegistrationContent(
                  onTapped: (index) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: AppSizes.registrationLeftRight,
                              right: AppSizes.registrationLeftRight,
                              bottom: 0,
                              top: 0),
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
                                      AppTexts.registerStudent,
                                      textAlign: TextAlign.center,
                                    )
                                  : const Text(
                                      AppTexts.registerTeacher,
                                      textAlign: TextAlign.center,
                                    ),
                              content: index == 0
                                  ? Container(
                                      color: Colors.transparent,
                                      width:
                                          HelperFunctions.screenWidth(context) *
                                              0.8, // Fixed width
                                      height: HelperFunctions.screenHeight(
                                              context) *
                                          0.6,
                                      child: AddStudentsScreen(
                                          onCancelClicked: () {
                                        Navigator.pop(context);
                                      }, onAddClicked: () {
                                        HelperFunctions.showSnackBar(context,
                                            AppTexts.studentRegistered);
                                        Navigator.pop(context);
                                      }))
                                  : Container(
                                      color: Colors.transparent,
                                      width:
                                          HelperFunctions.screenWidth(context) *
                                              0.8, // Fixed width
                                      height: HelperFunctions.screenHeight(
                                              context) *
                                          0.6,
                                      child: AddTeachersScreen(
                                          onCancelClicked: () {
                                        Navigator.pop(context);
                                      }, onAddClicked: () {
                                        HelperFunctions.showSnackBar(context,
                                            AppTexts.teacherRegistered);

                                        Navigator.pop(context);
                                      }),
                                    ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                )),

                /// School fees
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: SchoolFeesScreen(),
                  ),
                ),

                /// Classes
                Container(
                  color: Colors.white,
                  child: const Center(child: Text(AppTexts.comingSoon)),
                ),

                /// About
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.orangeAccent, Colors.white],
                  )),
                  //color: Colors.white,
                  child: const Center(child: Text(AppTexts.comingSoon)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
