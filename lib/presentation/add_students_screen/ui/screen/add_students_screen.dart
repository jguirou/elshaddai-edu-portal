import 'package:el_shaddai_edu_portal/presentation/add_students_screen/ui/widgets/students_school_level_fields.dart';
import 'package:el_shaddai_edu_portal/presentation/add_teachers_screen/ui/widgets/sex_choose.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/app_utils.dart';
import '../../../add_teachers_screen/ui/widgets/button_widget.dart';
import '../../../signup_screen/ui/widgets/form_container_widget.dart';

import '../../domain/bloc/add_students_bloc.dart';
import '../widgets/date_picker_field.dart';

class AddStudentsScreen extends StatefulWidget {
  final Function onAddClicked;
  final Function onCancelClicked;

  const AddStudentsScreen(
      {super.key, required this.onAddClicked, required this.onCancelClicked});

  @override
  State<AddStudentsScreen> createState() => _AddStudentsScreenState();
}

class _AddStudentsScreenState extends State<AddStudentsScreen> {
  String selectedClass = '1ère Année';
  DateTime selectedDate = DateTime.now();
  List<String> genderOptions = ['M', 'F'];
  String? _selectedGender;
  TextEditingController dateController =
      TextEditingController(); // Initial selected date

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider(
      create: (context) => AddStudentsBloc()
        ..add(const InitializeDatabase())
        ..add(const OnClassClicked()),
      child: BlocConsumer<AddStudentsBloc, AddStudentsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: SingleChildScrollView(
              child: Column(
                  children: [
                SexChoose(
                  gender: genderOptions,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                    context
                        .read<AddStudentsBloc>()
                        .add(OnGenderFieldChanged(_selectedGender!));
                  },
                  selectedGender: _selectedGender,
                ),
                const SizedBox(height: 20),
                FormContainerWidget(
                  hintText: "Prenom(s)",
                  isPasswordField: false,
                  onFieldValueChanged: (val) {
                    context
                        .read<AddStudentsBloc>()
                        .add(OnNameFieldChanged(val));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  onFieldValueChanged: (val) {
                    context
                        .read<AddStudentsBloc>()
                        .add(OnFamilyNameFieldChanged(val));
                  },
                  hintText: "Nom",
                  isPasswordField: false,
                ),
                const SizedBox(
                  height: 10,
                ),

                /// birthday
                DatePickerField(
                  dateController: dateController,
                  hintText: 'Date de Naissance',
                  onTapped: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1900),

                      // Set a minimum allowed date
                      lastDate: DateTime
                          .now(), // Set a maximum allowed date (current date)
                    );

                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                        dateController.text =
                            '${picked.toLocal()}'.split(' ')[0];
                      });
                      // Dispatch the event to the Bloc
                      context.read<AddStudentsBloc>().add(
                          OnDateOfBirthFieldChanged(
                              AppUtils.formatDateTime(selectedDate)));
                    }
                  },
                ),

                const SizedBox(
                  height: 10,
                ),
                const Text("Niveau scolaire", textAlign: TextAlign.start,),

                /// level
                const StudentsSchoolLevelFields(),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                 Text('Parents', style: Theme.of(context).textTheme.titleLarge, ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                FormContainerWidget(
                  hintText: "Prenom(s) du père",
                  isPasswordField: false,
                  onFieldValueChanged: (val) {
                    context
                        .read<AddStudentsBloc>()
                        .add(OnFatherNameFieldChanged(val));
                  },
                ),

                const SizedBox(
                  height: 10,
                ),

                FormContainerWidget(
                  onFieldValueChanged: (val) {
                    context
                        .read<AddStudentsBloc>()
                        .add(OnMotherNameFieldChanged(val));
                  },
                  hintText: "Prenom(s) de la mère",
                  isPasswordField: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  onFieldValueChanged: (val) {
                    context
                        .read<AddStudentsBloc>()
                        .add(OnMotherFamilyNameFieldChanged(val));
                  },
                  hintText: "Nom de la mère",
                  isPasswordField: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonWidget(
                      buttonColor: Colors.red,
                      onTapped: () {
                        widget.onCancelClicked();
                      },
                      title: "Annuler",
                    ),
                    ButtonWidget(
                      onTapped: () {
                        context
                            .read<AddStudentsBloc>()
                            .add(const OnAddClicked());
                        widget.onAddClicked();
                      },
                      title: "Valider",
                    ),
                  ],
                ),
              ]),
            ),
          );
        },
      ),
    ));
  }

}
