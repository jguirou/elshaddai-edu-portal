import 'package:el_shaddai_edu_portal/utils/constants/sizes.dart';
import 'package:el_shaddai_edu_portal/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../utils/formatters/formatter.dart';
import '../../../add_students/ui/widgets/date_picker_field.dart';
import '../../domain/bloc/add_teachers_bloc.dart';
import 'package:multiselect/multiselect.dart';

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
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider(
      create: (context) => AddTeachersBloc()..add(const OnGetClassLevel()),
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
                    TextFormField(
                      onChanged: (val) {
                        context
                            .read<AddTeachersBloc>()
                            .add(OnNameFieldChanged(val));
                      },
                      decoration:
                          const InputDecoration(labelText: AppTexts.firstName),
                    ),
                    const SizedBox(
                      height: AppSizes.spaceBtwInputField,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        context
                            .read<AddTeachersBloc>()
                            .add(OnFamilyNameFieldChanged(val));
                      },
                      decoration:
                          const InputDecoration(labelText: AppTexts.lastName),
                    ),

                    const SizedBox(
                      height: AppSizes.spaceBtwInputField,
                    ),

                    /// birthday
                    DatePickerField(
                      labelText: AppTexts.dateOfBirth,
                      dateController: dateController,
                      hintText: AppTexts.dateOfBirth,
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
                          if (context.mounted) {
                            context.read<AddTeachersBloc>().add(
                                OnDateOfBirthFieldChanged(
                                    Formatter.formatDate(selectedDate)));
                          }
                        }
                      },
                    ),
                    const SizedBox(
                      height: AppSizes.spaceBtwInputField,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
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
                          context
                              .read<AddTeachersBloc>()
                              .add(OnClassFieldChanged(x));
                        },
                        options: state.classes ?? selectedClasses,
                        selectedValues: selectedClasses,
                        whenEmpty: AppTexts.chooseClasses,
                      ),
                    ),

                    const SizedBox(
                      height: AppSizes.spaceBtwInputField,
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
                                AppTexts.cancel,
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
                            context
                                .read<AddTeachersBloc>()
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
                                AppTexts.validate,
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
