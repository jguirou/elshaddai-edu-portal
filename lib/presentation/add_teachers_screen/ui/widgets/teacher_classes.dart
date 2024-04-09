import 'package:el_shaddai_edu_portal/presentation/add_teachers_screen/domain/bloc/add_teachers_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherClasses extends StatefulWidget {
  const TeacherClasses({super.key});

  @override
  State<TeacherClasses> createState() => _TeacherClassesState();
}

class _TeacherClassesState extends State<TeacherClasses> {
  Set<String> selectedValues = {};

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTeachersBloc, AddTeachersState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selectionnez la/ les classes:',
                style: Theme.of(context).textTheme.titleLarge),
            Wrap(
              children: state.classes?.map((option) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedValues.contains(option)) {
                            selectedValues.remove(option);
                          } else {
                            selectedValues.add(option);
                          }
                          context.read<AddTeachersBloc>().add(
                              OnClassFieldChanged(selectedValues.toList()));
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: selectedValues.contains(option),
                            onChanged: (_) {
                              setState(() {
                                if (selectedValues.contains(option)) {
                                  selectedValues.remove(option);
                                } else {
                                  selectedValues.add(option);
                                }
                                context.read<AddTeachersBloc>().add(
                                    OnClassFieldChanged(
                                        selectedValues.toList()));
                              });
                            },
                          ),
                          Text(option),
                        ],
                      ),
                    );
                  }).toList() ??
                  [],
            ),
          ],
        );
      },
    );
  }
}
