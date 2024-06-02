import 'package:flutter/material.dart';

import 'package:el_shaddai_edu_portal/utils/constants/sizes.dart';
import 'package:expandable_datatable/expandable_datatable.dart';

import '../../../../../common/edit_text_field.dart';
import '../../../../../common/my_expandable_data_table.dart';
import '../../../../../domain/entities/students/students.dart';
import '../../../../../utils/constants/routes.dart';
import '../../../../../utils/constants/texts.dart';


class SchoolFeeExpandableDataTable extends StatefulWidget {
  const SchoolFeeExpandableDataTable(
      {super.key,
        required this.headers,
        required this.list,
        required this.onEdited,
        required this.visibleCount});

  final List<ExpandableColumn<dynamic>> headers;
  final List<Student> list;
  final dynamic Function(Student) onEdited;
  final int visibleCount;

  @override
  State<SchoolFeeExpandableDataTable> createState() =>
      _SchoolFeeExpandableDataTableState();
}

class _SchoolFeeExpandableDataTableState
    extends State<SchoolFeeExpandableDataTable> {
  @override
  Widget build(BuildContext context) {
    return MyExpandableDataTable(
      child: ExpandableDataTable(
        headers: widget.headers,
        rows: widget.list.map<ExpandableRow>((e) {
          List<ExpandableCell<dynamic>> cells = [
            ExpandableCell<String>(columnTitle: AppTexts.id, value: e.id),
            ExpandableCell<String>(
                columnTitle: AppTexts.firstName, value: e.name),
            ExpandableCell<String>(
                columnTitle: AppTexts.lastName, value: e.familyName),
            ExpandableCell<String>(
                columnTitle: AppTexts.dateOfBirth, value: e.birthDay),
            ExpandableCell<String>(
                columnTitle: AppTexts.schoolLevel, value: e.classLevel),
            ExpandableCell<String>(
                columnTitle: AppTexts.fatherFirstName, value: e.fatherName),
            ExpandableCell<String>(
                columnTitle: AppTexts.motherFirstName, value: e.motherName),
            ExpandableCell<String>(
                columnTitle: AppTexts.motherLastName,
                value: e.motherFamilyName),
            ExpandableCell<Map<String, int>>(
                columnTitle: AppTexts.schoolFee, value: e.schoolFees),
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
          row,
          onSuccess,
          onEdited: widget.onEdited,
        ),
        visibleColumnCount: widget.visibleCount,
      ),
    );
  }

  Widget _buildEditDialog(ExpandableRow row, Function(ExpandableRow) onSuccess,
      {required Function(Student students) onEdited}) {
    // Existing controllers
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController birthDateController = TextEditingController();
    TextEditingController fatherFirstNameController = TextEditingController();
    TextEditingController motherFirstNameController = TextEditingController();
    TextEditingController motherLastNameController = TextEditingController();
    GlobalKey<FormState> registerStudentKey = GlobalKey<FormState>();
// Extract values from cells dynamically
    firstNameController.text = getCellValue<String>(row, 1) ?? '';
    lastNameController.text = getCellValue<String>(row, 2) ?? '';
    birthDateController.text = getCellValue<String>(row, 3) ?? '';
    fatherFirstNameController.text = getCellValue<String>(row, 5) ?? '';
    motherFirstNameController.text = getCellValue<String>(row, 6) ?? '';
    motherLastNameController.text = getCellValue<String>(row, 7) ?? '';
    return SingleChildScrollView(
      child: AlertDialog(
        title: const Text(AppTexts.editStudentData),
        content: Form(
          key: registerStudentKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Existing text fields
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
              EditTextField(
                controller: fatherFirstNameController,
                labelText: AppTexts.fatherFirstName,
              ),
              const SizedBox(height: AppSizes.spaceBtwInputField),
              EditTextField(
                controller: motherFirstNameController,
                labelText: AppTexts.motherFirstName,
              ),
              const SizedBox(height: AppSizes.spaceBtwInputField),
              EditTextField(
                controller: motherLastNameController,
                labelText: AppTexts.motherLastName,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, Routes.schoolFees); // Close the dialog
            },
            child: const Text(AppTexts.schoolFee),
          ),
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

              row.cells[5].value = fatherFirstNameController.text;
              row.cells[6].value = motherFirstNameController.text;
              row.cells[7].value = motherLastNameController.text;
              onSuccess(row);

              Navigator.of(context).pop();
              final newStudents = Student(
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
            child: const Text(AppTexts.save),
          ),
        ],
      ),
    );
  }

}
