import 'package:flutter/material.dart';

import '../../../add_students_screen/ui/widgets/my_card_container.dart';
import 'home_content.dart';
class RegistrationContent extends StatelessWidget {
  final Function onTapped;
  const RegistrationContent({super.key, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    List<Item> items = [
      Item('Inscrire un(e) élève', 'assets/images/student.png'),
      Item('Inscrire un(e) enseignant(e)', 'assets/images/teacher.png'),

    ];
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            onTapped(index);

          },


            child: MyCardContainer(

                children: [
                  Column(
                    children: [
                      Image.asset(
                          items[index].icon
                      ),
                      const SizedBox(height: 10,),
                      Text(items[index].title),

                    ],
                  )
                ]

            ),

        );
      },
    );
  }
}

