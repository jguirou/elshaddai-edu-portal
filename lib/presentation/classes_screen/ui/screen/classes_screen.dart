import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/app_utils.dart';
import '../../../add_students_screen/ui/widgets/date_picker_field.dart';
import '../../../signup_screen/ui/widgets/form_container_widget.dart';
import '../../domain/bloc/classes_bloc.dart';

class ClassesScreen extends StatefulWidget {
  final Function onAddClicked;
  final Function onCancelClicked;

  const ClassesScreen(
      {super.key, required this.onAddClicked, required this.onCancelClicked});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
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
      create: (context) => ClassesBloc()
        ..add(const InitializeDatabase())
        ..add(const OnClassClicked()),
      child: BlocConsumer<ClassesBloc, ClassesState>(
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
                    context.read<ClassesBloc>().add(OnNameFieldChanged(val));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  onFieldValueChanged: (val) {
                    context
                        .read<ClassesBloc>()
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
                      context.read<ClassesBloc>().add(OnDateOfBirthFieldChanged(
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
                              .read<ClassesBloc>()
                              .add(OnClassFieldChanged(value));
                          context
                              .read<ClassesBloc>()
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
                        .read<ClassesBloc>()
                        .add(OnFatherNameFieldChanged(val));
                  },
                ),

                const SizedBox(
                  height: 10,
                ),

                FormContainerWidget(
                  onFieldValueChanged: (val) {
                    context
                        .read<ClassesBloc>()
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
                        .read<ClassesBloc>()
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
                        context.read<ClassesBloc>().add(const OnAddClicked());
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
