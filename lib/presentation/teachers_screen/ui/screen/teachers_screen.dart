import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/teachers/teachers.dart';
import '../../../students_screen/ui/widgets/edit_text_field.dart';
import 'package:expandable_datatable/expandable_datatable.dart';

import '../../domain/bloc/teachers_bloc.dart';

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
      ExpandableColumn<String>(columnTitle: "ID", columnFlex: 4),
      ExpandableColumn<String>(columnTitle: "Prénom(s)", columnFlex: 4),
      ExpandableColumn<String>(columnTitle: "Nom", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Date de naissance", columnFlex: 5),
      ExpandableColumn<List<String>>(columnTitle: "Classes", columnFlex: 5),
    ];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => TeachersBloc()
        ..add(const InitializeDatabase())
        ..add(const OnGetTeachers()),
      child: BlocConsumer<TeachersBloc, TeachersState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return !state.isLoading ? SafeArea(
            child: !state.isLoading && state.teachersList.isNotEmpty
                ? LayoutBuilder(builder: (context, constraints) {
                    int visibleCount = 5;

                    return ExpandableTheme(
                      data: ExpandableThemeData(
                        headerTextStyle: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold
                        ),
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
                      ),
                      child: ExpandableDataTable(
                        headers: headers,
                        rows: state.teachersList.map<ExpandableRow>((e) {
                          return ExpandableRow(cells: [
                            ExpandableCell<String>(
                                columnTitle: "ID", value: e.id),
                            ExpandableCell<String>(
                                columnTitle: "Prénom(s)", value: e.name),
                            ExpandableCell<String>(
                                columnTitle: "Nom", value: e.familyName),
                            ExpandableCell<String>(
                                columnTitle: "Date de naissance",
                                value: e.birthDay),
                            ExpandableCell<List<String>>(
                                columnTitle: "Classes", value: e.classes),
                          ]);
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
                            row, onSuccess,
                            (){
                              context.read<TeachersBloc>().add(OnDeletedTeacher(row.cells[0].value));
                            },
                            onEdited: (newTeacher) {
                          context
                              .read<TeachersBloc>()
                              .add(OnEditTeachersData(newTeacher));
                        }),
                        visibleColumnCount: visibleCount,
                      ),
                    );
                  })
                : const Center(child: CircularProgressIndicator()),
          ):const Center(child: CircularProgressIndicator());
        },
      ),
    ));
  }

  Widget _buildEditDialog(ExpandableRow row, Function(ExpandableRow) onSuccess,Function() onDelete,
      {required Function(Teachers teachers) onEdited}) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController birthDateController = TextEditingController();

    List<String> classesList = List<String>.from(row.cells[4].value ?? []);
    firstNameController.text = row.cells[1].value ?? '';
    lastNameController.text = row.cells[2].value ?? '';
    birthDateController.text = row.cells[3].value ?? '';

    return AlertDialog(
      title: const Text("Modifier les données de l'enseignant"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
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
          // Display and edit the list of classes
          Wrap(
            children: classesList
                .map(
                  (classItem) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Chip(
                      label: Text(classItem),
                      onDeleted: () {
                        setState(() {
                          classesList.remove(classItem);
                        });
                      },
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
      actions: [
        TextButton(

          onPressed: (){
            onDelete();
            Navigator.of(context).pop();
          },
          child: const Text("Supprimer l'enseignant"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Quitter'),
        ),

        TextButton(
          onPressed: () {
            // Perform the update with the new values
            row.cells[1].value = firstNameController.text;
            row.cells[2].value = lastNameController.text;
            row.cells[3].value = birthDateController.text;
            row.cells[4].value = classesList;

            onSuccess(row);

            Navigator.of(context).pop();
            final newTeacher = Teachers(
                id: row.cells[0].value,
                name: row.cells[1].value,
                familyName: row.cells[2].value,
                birthDay: row.cells[3].value,
                classes: row.cells[4].value);
            onEdited(newTeacher); // Close the dialog
          },
          child: const Text('Sauvegarder'),
        ),
      ],
    );
  }
}
