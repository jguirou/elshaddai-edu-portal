import 'package:el_shaddai_edu_portal/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/themes/custom_theme/expandable_data_table_theme.dart';
import '../../domain/bloc/school_fees_bloc.dart';

class SchoolFeesScreen extends StatefulWidget {
  const SchoolFeesScreen({Key? key}) : super(key: key);

  @override
  _SchoolFeesScreenState createState() => _SchoolFeesScreenState();
}

class _SchoolFeesScreenState extends State<SchoolFeesScreen> {
  late List<ExpandableColumn<dynamic>> headers;
  late List<ExpandableRow> rows;

  @override
  void initState() {
    super.initState();
    createDataSource();
  }

  void createDataSource() {
    headers = [
      ExpandableColumn<String>(columnTitle: AppTexts.id, columnFlex: 6),
      ExpandableColumn<String>(columnTitle: AppTexts.firstName, columnFlex: 12),
      ExpandableColumn<String>(columnTitle: AppTexts.lastName, columnFlex: 10),
      for (var month in schoolMonths)
        ExpandableColumn<String>(columnTitle: month, columnFlex: 6),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SchoolFeesBloc()
          ..add(const OnGetStudents()),
        child: BlocConsumer<SchoolFeesBloc, SchoolFeesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return !state.isLoading && state.studentsList.isNotEmpty
                ? LayoutBuilder(
                    builder: (context, constraints) {
                      final theme = Theme.of(context);
                      final expandableTheme = theme.brightness == Brightness.light
                          ? ExpandableCustomTheme.lightExpandableTheme(context)
                          : ExpandableCustomTheme.darkExpandableTheme(context);
                      return ExpandableTheme(
                        data: expandableTheme,
                        child: ExpandableDataTable(
                          headers: headers,
                          rows: state.studentsList.map<ExpandableRow>((e) {
                            List<ExpandableCell<dynamic>> cells = [
                              ExpandableCell<String>(
                                  columnTitle: AppTexts.id, value: e.id),
                              ExpandableCell<String>(
                                  columnTitle: AppTexts.firstName, value: e.name),
                              ExpandableCell<String>(
                                  columnTitle: AppTexts.lastName, value: e.familyName),
                              for (var _ in schoolMonths)
                                ExpandableCell<String>(
                                    columnTitle: _,
                                    value: e.schoolFees?[_]?.toString() ?? '0'),
                            ];

                            return ExpandableRow(cells: cells);
                          }).toList(),
                          isEditable: true,
                          onRowChanged: (newRow) {
                            final studentId = newRow.cells[0].value;


                            // Prepare the school fees data from the row
                            final Map<String, int> schoolFees = {};
                            for (var i = 2; i < newRow.cells.length; i++) {
                              schoolFees[headers[i].columnTitle] =
                                  int.tryParse(newRow.cells[i].value) ?? 0;
                            }
                            context.read<SchoolFeesBloc>().add(
                                (OnSchoolFeesUpdated(studentId, schoolFees)));
                            // Handle row changes
                          },
                          visibleColumnCount: 14,
                          // Add any additional configurations or callbacks
                        ),
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

final List<String> schoolMonths = [
  'Septembre',
  'Octobre',
  'Novembre',
  'Decembre',
  'Janvier',
  'Fevrier',
  'Mars',
  'Avril',
  'Mai',
  'Juin',
  'Juillet',
  'Aout',
];
