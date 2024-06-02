import 'package:el_shaddai_edu_portal/utils/constants/texts.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../registration/add_students/ui/widgets/my_card_container.dart';
import 'home_content.dart';

class RegistrationContent extends StatelessWidget {
  final Function onTapped;

  const RegistrationContent({super.key, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    List<Item> items = [
      Item(AppTexts.registerStudent, AppImages.student),
      Item(AppTexts.registerTeacher, AppImages.teacher),
    ];
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            onTapped(index);
          },
          child: MyCardContainer(children: [
            Column(
              children: [
                Image.asset(items[index].icon),
                const SizedBox(
                  height: 10,
                ),
                Text(items[index].title),
              ],
            )
          ]),
        );
      },
    );
  }
}
