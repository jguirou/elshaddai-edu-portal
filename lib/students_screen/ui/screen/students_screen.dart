import 'package:el_shaddai_edu_portal/students_screen/domain/model/students.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../school_fees_screen/ui/screen/school_fees_screen.dart';
import '../../domain/bloc/students_bloc.dart';
import 'package:expandable_datatable/expandable_datatable.dart';

import '../widgets/edit_text_field.dart';

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
  late Map<String, int> schoolFees ;

  @override
  void initState() {
    // TODO: implement initState
    createDataSource();
    super.initState();
  }

  void createDataSource() {
    headers = [
      ExpandableColumn<String>(columnTitle: "ID", columnFlex: 4),
      ExpandableColumn<String>(columnTitle: "Prénom(s)", columnFlex: 4),
      ExpandableColumn<String>(columnTitle: "Nom", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Date de naissance", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Niveau scolaire", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Prénom(s) du père", columnFlex: 3),
      ExpandableColumn<String>(
          columnTitle: "Prénom(s) de la mère", columnFlex: 3),
      ExpandableColumn<String>(columnTitle: "Nom de la mère", columnFlex: 3),
      ExpandableColumn<Map<String, int>>(columnTitle: "Frais de scolarité", columnFlex: 3),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => StudentsBloc()
        ..add(const InitializeDatabase())
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

                    return ExpandableTheme(
                      data: ExpandableThemeData(
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
                      ),
                      child: ExpandableDataTable(
                        headers: headers,
                        rows: state.studentsList.map<ExpandableRow>((e) {
                          List<ExpandableCell<dynamic>> cells = [
                            ExpandableCell<String>(columnTitle: "ID", value: e.id),
                            ExpandableCell<String>(columnTitle: "Prénom(s)", value: e.name),
                            ExpandableCell<String>(columnTitle: "Nom", value: e.familyName),
                            ExpandableCell<String>(columnTitle: "Date de naissance", value: e.birthDay),
                            ExpandableCell<String>(columnTitle: "Niveau scolaire", value: e.classLevel),
                            ExpandableCell<String>(columnTitle: "Prénom(s) du père", value: e.fatherName),
                            ExpandableCell<String>(columnTitle: "Prénom(s) de la mère", value: e.motherName),
                            ExpandableCell<String>(columnTitle: "Nom de la mère", value: e.motherFamilyName),
                            ExpandableCell<Map<String, int>>(columnTitle: "Frais de scolarité", value: e.schoolFees),
                          ];


                          return ExpandableRow(cells: cells);
                        }).toList(),
                        multipleExpansion: false,
                        isEditable: true,
                        onRowChanged: (newRow) {
                          print(newRow.cells[01].value);
                        },
                        onPageChanged: (page) {
                          print(page);
                        },
                        renderEditDialog: (row, onSuccess) => _buildEditDialog(
                            row, onSuccess, onEdited: (newStudents) {
                          context
                              .read<StudentsBloc>()
                              .add(OnEditStudentsData(newStudents));
                        }, ),
                        visibleColumnCount: visibleCount,
                      ),
                    );
                  })
                : const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    ));
  }

  Widget _buildEditDialog(
      ExpandableRow row,
      Function(ExpandableRow) onSuccess,
      {required Function(Students students) onEdited}
      ) {
    // Existing controllers
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController birthDateController = TextEditingController();
    TextEditingController fatherFirstNameController = TextEditingController();
    TextEditingController motherFirstNameController = TextEditingController();
    TextEditingController motherLastNameController = TextEditingController();
// Extract values from cells dynamically
    firstNameController.text = getCellValue<String>(row, 1) ?? '';
    lastNameController.text = getCellValue<String>(row, 2) ?? '';
    birthDateController.text = getCellValue<String>(row, 3) ?? '';
    fatherFirstNameController.text = getCellValue<String>(row, 5) ?? '';
    motherFirstNameController.text = getCellValue<String>(row, 6) ?? '';
    motherLastNameController.text = getCellValue<String>(row, 7) ?? '';
    return AlertDialog(
      title: const Text("Modifier les données de l'élève"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Existing text fields
          EditTextField(
            controller: firstNameController,
            labelText: 'Prénom',
          ),
          EditTextField(
            controller: lastNameController,
            labelText: 'Nom',
          ),
          EditTextField(
            controller: birthDateController,
            labelText: 'Date de naissance',
          ),
          EditTextField(
            controller: fatherFirstNameController,
            labelText: 'Prénom(s) du père',
          ),
          EditTextField(
            controller: motherFirstNameController,
            labelText: 'Prénom(s) de la mère',
          ),
          EditTextField(
            controller: motherLastNameController,
            labelText: 'Nom de la mère',
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/school_fees'); // Close the dialog
          },
          child: const Text('Frais de scolarité'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Perform the update with the new values
            row.cells[1].value = firstNameController.text;
            row.cells[2].value = lastNameController.text;
            row.cells[3].value = birthDateController.text;

            row.cells[5].value = fatherFirstNameController.text;
            row.cells[6].value = motherFirstNameController.text;
            row.cells[7].value = motherLastNameController.text;
            onSuccess(row);

            Navigator.of(context).pop();
            final newStudents = Students(
              id: row.cells[0].value,
              name: row.cells[1].value,
              familyName: row.cells[2].value,
              birthDay: row.cells[3].value,
              fatherName: row.cells[5].value,
              motherName: row.cells[6].value,
              motherFamilyName: row.cells[7].value,
              schoolFees: row.cells[8].value,
            );
            onEdited(newStudents); // Close the dialog
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
  // Helper function to extract cell values dynamically
  T? getCellValue<T>(ExpandableRow row, int index) {
    try {
      // Try to cast the value to the specified type
      return row.cells[index].value as T?;
    } catch (e) {
      // Handle any potential errors during casting
      return null;
    }
  }

}


