import 'package:flutter/material.dart';

import '../../../add_students_screen/ui/widgets/my_card_container.dart';
import '../../domain/bloc/classes_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassesContent extends StatelessWidget {
  final Function onTapped;

  const ClassesContent({super.key, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClassesBloc()
        ..add(const InitializeDatabase())
        ..add(const OnClassClicked()),
      child: BlocConsumer<ClassesBloc, ClassesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return state.classes != null
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.classes!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        onTapped(state.classes![index]);
                      },
                      child: MyCardContainer(children: [
                        Column(
                          children: [
                            Text(state.classes![index]),
                          ],
                        )
                      ]),
                    );
                  },
                )
              : const CircularProgressIndicator();
        },
      ),
    );
  }
}
