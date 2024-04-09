import 'package:el_shaddai_edu_portal/presentation/add_students_screen/domain/bloc/add_students_bloc.dart';
import 'package:el_shaddai_edu_portal/presentation/add_students_screen/domain/bloc/add_students_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsSchoolLevelFields extends StatefulWidget {
  const StudentsSchoolLevelFields({super.key});

  @override
  State<StudentsSchoolLevelFields> createState() =>
      _StudentsSchoolLevelFieldsState();
}

class _StudentsSchoolLevelFieldsState extends State<StudentsSchoolLevelFields> {
  String selectedClass = '1ère Année';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddStudentsBloc, AddStudentsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.35),
            borderRadius: BorderRadius.circular(35),
          ),
          child: DropdownButton<String>(
            focusColor: Colors.transparent,
            borderRadius: BorderRadius.circular(35),
            underline: Container(),
            //icon: null,
            value: selectedClass,
            isExpanded: true,
            items: state.classes?.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(value),
                ),
                onTap: () {
                  context
                      .read<AddStudentsBloc>()
                      .add(OnClassFieldChanged(value));
                  context
                      .read<AddStudentsBloc>()
                      .add(const OnClassClicked());
                },
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedClass = newValue ?? '';
              });
            },
          ),
        );
      },
    );
  }
}
