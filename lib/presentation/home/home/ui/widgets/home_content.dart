import 'package:el_shaddai_edu_portal/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../registration/add_students/ui/widgets/my_card_container.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key, required this.onTapped});

  final Function onTapped;

  @override
  Widget build(BuildContext context) {
    List<Item> items = [
      Item(AppTexts.students, AppImages.student),
      Item(AppTexts.teacher, AppImages.teacher),
      Item(AppTexts.classes, AppImages.classes),
      Item(AppTexts.subscription, AppImages.inscription),
    ];
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            onTapped(items[index].title);
          },
          child: MyCardContainer(children: [
            Column(
              children: [
                Image.asset(items[index].icon),
                const SizedBox(
                  height: AppSizes.sm,
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

class Item {
  final String title;
  final String icon;

  Item(
    this.title,
    this.icon,
  );
}
