import 'package:el_shaddai_edu_portal/utils/helpers/helper_functions.dart';
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
  String _selectedYear = HelperFunctions.getActualSchoolYear();

  @override
  void initState() {
    // TODO: implement initState
    createDataSource();
    super.initState();
    _selectedYear = HelperFunctions.getActualSchoolYear();
  }

  void createDataSource() {
    headers = [
      ExpandableColumn<String>(columnTitle: AppTexts.id, columnFlex: 4),
      ExpandableColumn<String>(columnTitle: AppTexts.firstName, columnFlex: 4),
      ExpandableColumn<String>(columnTitle: AppTexts.lastName, columnFlex: 2),
      ExpandableColumn<String>(
          columnTitle: AppTexts.dateOfBirth, columnFlex: 3),
      ExpandableColumn<String>(
          columnTitle: AppTexts.schoolLevel, columnFlex: 3),
      ExpandableColumn<String>(
          columnTitle: AppTexts.fatherFirstName, columnFlex: 3),
      ExpandableColumn<String>(
          columnTitle: AppTexts.motherFirstName, columnFlex: 3),
      ExpandableColumn<String>(
          columnTitle: AppTexts.motherLastName, columnFlex: 3),
      ExpandableColumn<Map<String, int>>(
          columnTitle: AppTexts.schoolFee, columnFlex: 3),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final actualSchoolYear = HelperFunctions.getActualSchoolYear();
    return Scaffold(
        body: BlocProvider(
      create: (context) => StudentsBloc()
        ..add(const OnGetAllSchoolYears())
        ..add(OnGetStudents(actualSchoolYear)),
      child: BlocConsumer<StudentsBloc, StudentsState>(
        listener: (context, state) {
          // TODO: implement listenerÅ
        },
        builder: (context, state) {
          return SafeArea(
            child: (state.isLoading  && state.listOfSchoolYear.isEmpty ) || (state.isLoading  && state.studentsList.isEmpty)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.listOfSchoolYear.isEmpty ? const Center(child: Text("Aucune anée civile dispo et aucun élève inscrit")): state.listOfSchoolYear.isNotEmpty && state.studentsList.isNotEmpty ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(AppTexts.schoolYear.toUpperCase(),
                              style: Theme.of(context).textTheme.bodyLarge),
                          DropdownButton<String>(
                            focusColor: Colors.transparent,
                            value: _selectedYear,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedYear = newValue!;
                                context
                                    .read<StudentsBloc>()
                                    .add(OnGetStudents(_selectedYear));
                              });
                              // Reload screen and call getAllStudents
                            },
                            items: state.listOfSchoolYear?.map((String year) {
                              return DropdownMenuItem<String>(
                                value: year,
                                child: Text(year),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                      LayoutBuilder(builder: (context, constraints) {
                        int visibleCount = 5;

                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: StudentsExpandableDataTable(
                              headers: headers,
                              list: state.studentsList,
                              onEdited: (newStudents) {
                                context
                                    .read<StudentsBloc>()
                                    .add(OnEditStudentsData(newStudents));
                              },
                              visibleCount: visibleCount),
                        );
                      }),
                    ],
                  ):   const Center(child: Text("Aucun élève inscrit, Vous pouvez inscrire des élèves")),
          );
        },
      ),
    ));
  }
}



