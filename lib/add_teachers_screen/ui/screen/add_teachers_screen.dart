import 'package:el_shaddai_edu_portal/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../add_students_screen/ui/widgets/date_picker_field.dart';
import '../../../signup_screen/ui/widgets/form_container_widget.dart';
import '../../domain/bloc/add_teachers_bloc.dart';
import 'package:multiselect/multiselect.dart';
import 'package:intl/intl.dart';
class AddTeachersScreen extends StatefulWidget {
  final Function onAddClicked;
  final Function onCancelClicked;

  const AddTeachersScreen(
      {super.key, required this.onAddClicked, required this.onCancelClicked});

  @override
  State<AddTeachersScreen> createState() => _AddTeachersScreenState();
}

class _AddTeachersScreenState extends State<AddTeachersScreen> {
  List<String> selectedClasses = [];
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController =
  TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider(
      create: (context) => AddTeachersBloc()
        ..add(const InitializeDatabase())
        ..add(const OnClassClicked()),
      child: BlocConsumer<AddTeachersBloc, AddTeachersState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                FormContainerWidget(
                  hintText: "Prenom(s)",
                  isPasswordField: false,
                  onFieldValueChanged: (val) {
                    context.read<AddTeachersBloc>().add(OnNameFieldChanged(val));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  onFieldValueChanged: (val) {
                    context
                        .read<AddTeachersBloc>()
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
                      context.read<AddTeachersBloc>().add(
                          OnDateOfBirthFieldChanged(
                              AppUtils.formatDateTime(selectedDate)));
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.35),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropDownMultiSelect(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black45),
                    ),
                    onChanged: (List<String> x) {
                      setState(() {
                        selectedClasses = x;
                      });
                      context.read<AddTeachersBloc>().add(OnClassFieldChanged(x));
                    },
                    options: state.classes ?? selectedClasses,
                    selectedValues: selectedClasses,
                    whenEmpty: 'Choisissez les classes',
                  ),
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
                        context.read<AddTeachersBloc>().add(const OnAddClicked());
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
