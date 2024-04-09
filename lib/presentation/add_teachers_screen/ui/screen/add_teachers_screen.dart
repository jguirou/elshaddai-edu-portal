import 'package:el_shaddai_edu_portal/presentation/add_teachers_screen/ui/widgets/button_widget.dart';
import 'package:el_shaddai_edu_portal/presentation/add_teachers_screen/ui/widgets/teacher_classes.dart';
import 'package:el_shaddai_edu_portal/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../add_students_screen/ui/widgets/date_picker_field.dart';
import '../../../signup_screen/ui/widgets/form_container_widget.dart';
import '../../domain/bloc/add_teachers_bloc.dart';
import '../widgets/sex_choose.dart';

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
  List<String> genderOptions = ['M', 'F'];
  String? _selectedGender;
  Set<String> selectedValues = {};
  TextEditingController dateController = TextEditingController();

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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Widget to select teacher or students sex.
                    SexChoose(
                      gender: genderOptions,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                        context
                            .read<AddTeachersBloc>()
                            .add(OnGenderFieldChanged(_selectedGender!));
                      },
                      selectedGender: _selectedGender,
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    /// First name text fields
                    FormContainerWidget(
                      hintText: "Prenom(s)",
                      isPasswordField: false,
                      onFieldValueChanged: (val) {
                        context
                            .read<AddTeachersBloc>()
                            .add(OnNameFieldChanged(val));
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    /// Last name text fields
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
                      height: 20,
                    ),
                    const Divider(),
                    const TeacherClasses(),
                    const Divider(),

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
                                .read<AddTeachersBloc>()
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
