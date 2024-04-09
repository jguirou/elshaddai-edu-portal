import 'package:flutter/material.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/app_utils.dart';
import '../../domain/bloc/school_fees_bloc.dart';

class SchoolFeesScreen extends StatefulWidget {
  const SchoolFeesScreen({Key? key}) : super(key: key);

  @override
  _SchoolFeesScreenState createState() => _SchoolFeesScreenState();
}

class _SchoolFeesScreenState extends State<SchoolFeesScreen> {
  late List<ExpandableColumn<dynamic>> headers;
  late List<ExpandableRow> rows;
  String _selectedYear = AppUtils().getActualSchoolYear();

  @override
  void initState() {
    super.initState();
    createDataSource();
    _selectedYear = AppUtils().getActualSchoolYear();
  }

  void createDataSource() {
    // Define your headers (e.g., student information and months)
    headers = [
      ExpandableColumn<String>(columnTitle: "ID", columnFlex: 6),
      ExpandableColumn<String>(columnTitle: "Prénom", columnFlex: 10),
      ExpandableColumn<String>(columnTitle: "Nom", columnFlex: 10),
      for (var month in schoolMonths)
        ExpandableColumn<String>(columnTitle: month, columnFlex: 10),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SchoolFeesBloc()
          ..add(const InitializeDatabase())
          ..add(const OnGetAllSchoolYears())
          ..add(OnGetStudents(AppUtils().getActualSchoolYear())),
        child: BlocConsumer<SchoolFeesBloc, SchoolFeesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return !state.isLoading && state.studentsList.isNotEmpty
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Année scolaire: ".toUpperCase(),
                            style: Theme.of(context).textTheme.bodyLarge
                          ),
                          DropdownButton<String>(
                            autofocus: false,

                            focusColor: Colors.transparent,

                            value: _selectedYear,
                            //hint: const Text('Select School Year'),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedYear = newValue!;

                                context
                                    .read<SchoolFeesBloc>()
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
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: ExpandableTheme(
                              key: UniqueKey(),
                              data: ExpandableThemeData(
                                headerTextStyle: const TextStyle(
                                    fontSize: 8, fontWeight: FontWeight.bold),
                                rowTextMaxLines: 1,
                                rowTextStyle: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                context,
                                contentPadding: const EdgeInsets.all(20),
                                expandedBorderColor: Colors.transparent,
                                paginationSize: 48,
                                headerHeight: 56,
                                headerColor: Colors.amber[400],
                                headerBorder: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                evenRowColor: const Color(0xFFFFFFFF),
                                oddRowColor: Colors.amber[100],
                                rowBorder: const BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),

                                rowColor: Colors.green,
                                headerTextMaxLines: 4,
                                headerSortIconColor: Colors.blue,
                                paginationSelectedFillColor: Colors.blue,
                                paginationSelectedTextColor: Colors.white,
                                //contentCellHeight: 56, // Set the contentCellHeight to make cells square

                                // Customize theme as needed
                              ),
                              child: ExpandableDataTable(
                                headers: headers,
                                rows:
                                    state.studentsList.map<ExpandableRow>((e) {
                                  List<ExpandableCell<dynamic>> cells = [
                                    ExpandableCell<String>(
                                        columnTitle: "ID", value: e.id),
                                    ExpandableCell<String>(
                                        columnTitle: "Prénom", value: e.name),
                                    ExpandableCell<String>(
                                        columnTitle: "Nom",
                                        value: e.familyName),
                                    for (var _ in schoolMonths)
                                      ExpandableCell<String>(
                                          columnTitle: _,
                                          value: e.schoolFees?[_]?.toString() ??
                                              '0'),
                                  ];

                                  return ExpandableRow(cells: cells);
                                }).toList(),
                                isEditable: true,
                                onRowChanged: (newRow) {
                                  final studentId = newRow.cells[0].value;

                                  // Prepare the school fees data from the row
                                  final Map<String, int> schoolFees = {};
                                  for (var i = 3;
                                      i < newRow.cells.length;
                                      i++) {
                                    schoolFees[headers[i].columnTitle] =
                                        int.tryParse(newRow.cells[i].value) ??
                                            0;
                                  }
                                  context.read<SchoolFeesBloc>().add(
                                      (OnSchoolFeesUpdated(
                                          studentId, schoolFees, _selectedYear)));
                                  // Handle row changes
                                },
                                visibleColumnCount: 14,
                                // Add any additional configurations or callbacks
                              ),
                            ),
                          );
                        },
                      ),
                    ],
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
  'Décembre',
  'Janvier',
  'Février',
  'Mars',
  'Avril',
  'Mai',
  'Juin',
  'Juillet',
  'Août',
];
