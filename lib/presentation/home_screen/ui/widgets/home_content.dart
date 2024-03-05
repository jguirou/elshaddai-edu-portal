import 'package:flutter/material.dart';

import '../../../add_students_screen/ui/widgets/my_card_container.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key, required this.onTapped});

  final Function onTapped;

  @override
  Widget build(BuildContext context) {
    List<Item> items = [
      Item('Élèves', 'assets/images/student.png'),
      Item('Enseignants', 'assets/images/teacher.png'),
      Item('Classes', 'assets/images/class.png'),
      Item('Inscription', 'assets/images/inscription.png'),
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

class Item {
  final String title;
  final String icon;

  Item(
    this.title,
    this.icon,
  );
}
