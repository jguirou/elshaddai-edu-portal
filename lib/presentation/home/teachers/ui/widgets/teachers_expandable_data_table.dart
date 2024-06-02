import 'package:el_shaddai_edu_portal/common/my_expandable_data_table.dart';
import 'package:flutter/material.dart';
import 'package:expandable_datatable/expandable_datatable.dart';

import '../../../../../common/edit_text_field.dart';
import '../../../../../domain/entities/teachers/teachers.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class TeachersExpandableDataTable extends StatefulWidget {
  const TeachersExpandableDataTable(
      {super.key,
      required this.headers,
      required this.list,
      required this.onEdited,
      required this.visibleCount});

  final List<ExpandableColumn<dynamic>> headers;
  final List<Teacher> list;
  final dynamic Function(Teacher) onEdited;
  final int visibleCount;

  @override
  State<TeachersExpandableDataTable> createState() =>
      _TeachersExpandableDataTableState();
}

class _TeachersExpandableDataTableState
    extends State<TeachersExpandableDataTable> {
  @override
  Widget build(BuildContext context) {
    return MyExpandableDataTable(
      child: ExpandableDataTable(
        headers: widget.headers,
        rows: widget.list.map<ExpandableRow>((e) {
          return ExpandableRow(cells: [
            ExpandableCell<String>(columnTitle: AppTexts.id, value: e.id),
            ExpandableCell<String>(
                columnTitle: AppTexts.firstName, value: e.name),
            ExpandableCell<String>(
                columnTitle: AppTexts.lastName, value: e.familyName),
            ExpandableCell<String>(
                columnTitle: AppTexts.dateOfBirth, value: e.birthDay),
            ExpandableCell<List<String>>(
                columnTitle: AppTexts.classes, value: e.classes),
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
        renderEditDialog: (row, onSuccess) =>
            _buildEditDialog(row, onSuccess, onEdited: widget.onEdited),
        visibleColumnCount: widget.visibleCount,
      ),
    );
  }

  Widget _buildEditDialog(ExpandableRow row, Function(ExpandableRow) onSuccess,
      {required Function(Teacher teachers) onEdited}) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController birthDateController = TextEditingController();
    GlobalKey<FormState> registerTeacherKey = GlobalKey<FormState>();

    List<String> classesList = List<String>.from(row.cells[4].value ?? []);
    firstNameController.text = row.cells[1].value ?? '';
    lastNameController.text = row.cells[2].value ?? '';
    birthDateController.text = row.cells[3].value ?? '';

    return AlertDialog(
      title: const Text(AppTexts.editTeacherData),
      content: Form(
        key: registerTeacherKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditTextField(
              controller: firstNameController,
              labelText: AppTexts.firstName,
            ),
            const SizedBox(height: AppSizes.spaceBtwInputField),
            EditTextField(
              controller: lastNameController,
              labelText: AppTexts.lastName,
            ),
            const SizedBox(height: AppSizes.spaceBtwInputField),
            EditTextField(
              controller: birthDateController,
              labelText: AppTexts.dateOfBirth,
            ),
            const SizedBox(height: AppSizes.spaceBtwInputField),
            // Display and edit the list of classes
            /*Wrap(
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
            )*/
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(AppTexts.cancel),
        ),
        TextButton(
          onPressed: () {
            // Perform the update with the new values
            row.cells[1].value = firstNameController.text;
            row.cells[2].value = lastNameController.text;
            row.cells[3].value = birthDateController.text;
            // row.cells[4].value = classesList;

            onSuccess(row);

            Navigator.of(context).pop();
            final newTeacher = Teacher(
                id: row.cells[0].value,
                name: row.cells[1].value,
                familyName: row.cells[2].value,
                birthDay: row.cells[3].value,
                classes: row.cells[4].value);
            onEdited(newTeacher); // Close the dialog
          },
          child: const Text(AppTexts.save),
        ),
      ],
    );
  }
}
