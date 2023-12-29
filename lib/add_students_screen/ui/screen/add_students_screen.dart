import 'package:el_shaddai_edu_portal/add_students_screen/domain/bloc/add_students_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../signup_screen/ui/widgets/form_container_widget.dart';

import '../../../utils/app_utils.dart';
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
              child: Column(children: [
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
                      locale: const Locale('fr', 'FR'),
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

                /// level
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.35),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(

                    underline: Container(),
                    //icon: null,
                    value: selectedClass,
                    isExpanded: true,
                    items: state.classes?.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(value),
                        ),
                        onTap: () {
                          context
                              .read<AddStudentsBloc>()
                              .add(OnClassFieldChanged(value));
                          context
                              .read<AddStudentsBloc>()
                              .add(const OnClassClicked());
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedClass = newValue ?? '';
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Parents'),
                const SizedBox(
                  height: 10,
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
                    GestureDetector(
                      onTap: () {
                        widget.onCancelClicked();
                        //_signIn();
                        /// reload page
                      },
                      child: Container(
                        width: 99,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Annuler",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //_signIn();
                        context
                            .read<AddStudentsBloc>()
                            .add(const OnAddClicked());
                        widget.onAddClicked();
                      },
                      child: Container(
                        width: 99,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Valider",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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
