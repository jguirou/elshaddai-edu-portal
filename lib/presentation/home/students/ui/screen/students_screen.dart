import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/constants/texts.dart';
import '../../domain/bloc/students_bloc.dart';
import 'package:expandable_datatable/expandable_datatable.dart';

import '../widgets/students_expandable_data_table.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({
    super.key,
  });

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  late List<ExpandableColumn<dynamic>> headers;
  late List<ExpandableRow> rows;
  late Map<String, int> schoolFees;

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
      ExpandableColumn<String>(columnTitle: AppTexts.schoolLevel, columnFlex: 3),
      ExpandableColumn<String>(columnTitle: AppTexts.fatherFirstName, columnFlex: 3),
      ExpandableColumn<String>(
          columnTitle: AppTexts.motherFirstName, columnFlex: 3),
      ExpandableColumn<String>(columnTitle: AppTexts.motherLastName, columnFlex: 3),
      ExpandableColumn<Map<String, int>>(
          columnTitle: AppTexts.schoolFee, columnFlex: 3),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => StudentsBloc()
        ..add(const OnGetStudents()),
      child: BlocConsumer<StudentsBloc, StudentsState>(
        listener: (context, state) {
          // TODO: implement listenerÅ
        },
        builder: (context, state) {
          return SafeArea(
            child: !state.isLoading && state.studentsList.isNotEmpty
                ? LayoutBuilder(builder: (context, constraints) {
                    int visibleCount = 5;

                    return StudentsExpandableDataTable(
                        headers: headers,
                        list: state.studentsList,
                        onEdited: (newStudents) {
                          context
                              .read<StudentsBloc>()
                              .add(OnEditStudentsData(newStudents));
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
