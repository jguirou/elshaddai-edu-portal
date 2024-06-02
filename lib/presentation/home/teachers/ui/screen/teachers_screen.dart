import 'package:el_shaddai_edu_portal/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expandable_datatable/expandable_datatable.dart';

import '../../domain/bloc/teachers_bloc.dart';
import '../widgets/teachers_expandable_data_table.dart';

class TeachersScreen extends StatefulWidget {
  const TeachersScreen({
    super.key,
  });

  @override
  State<TeachersScreen> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  late List<ExpandableColumn<dynamic>> headers;
  late List<ExpandableRow> rows;

  @override
  void initState() {
    // TODO: implement initState
    createDataSource();
    super.initState();
  }

  void createDataSource() {
    headers = [
      ExpandableColumn<String>(columnTitle: AppTexts.id, columnFlex: 4),
      ExpandableColumn<String>(columnTitle: AppTexts.firstName, columnFlex: 4),
      ExpandableColumn<String>(columnTitle: AppTexts.lastName, columnFlex: 2),
      ExpandableColumn<String>(columnTitle: AppTexts.dateOfBirth, columnFlex: 3),
      ExpandableColumn<List<String>>(columnTitle: AppTexts.classes, columnFlex: 5),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => TeachersBloc()
        ..add(const OnGetTeachers()),
      child: BlocConsumer<TeachersBloc, TeachersState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return SafeArea(
            child: !state.isLoading && state.teachersList.isNotEmpty
                ? LayoutBuilder(builder: (context, constraints) {
                    int visibleCount = 5;

                    return TeachersExpandableDataTable(
                        headers: headers,
                        list: state.teachersList,
                        onEdited: (newTeacher) {
                          context
                              .read<TeachersBloc>()
                              .add(OnEditTeachersData(newTeacher));
                        },
                        visibleCount: visibleCount
                    );
                  })
                : const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    ));
  }

}
