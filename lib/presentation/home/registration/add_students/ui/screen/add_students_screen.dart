import 'package:el_shaddai_edu_portal/utils/constants/sizes.dart';
import 'package:el_shaddai_edu_portal/utils/constants/texts.dart';
import 'package:el_shaddai_edu_portal/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/bloc/add_students_bloc.dart';
import '../widgets/date_picker_field.dart';

class AddStudentsScreen extends StatefulWidget {
  final Function()? onAddClicked;
  final Function()? onCancelClicked;

  const AddStudentsScreen({super.key, this.onAddClicked, this.onCancelClicked});

  @override
  State<AddStudentsScreen> createState() => _AddStudentsScreenState();
}

class _AddStudentsScreenState extends State<AddStudentsScreen> {
  String selectedClass = '';
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
      create: (context) => AddStudentsBloc()..add(const OnGetClassLevel()),
      child: BlocConsumer<AddStudentsBloc, AddStudentsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                // First Name Field
                TextFormField(
                  onChanged: (val) {
                    context.read<AddStudentsBloc>().add(OnNameFieldChanged(val));
                  },
                  decoration:
                      const InputDecoration(labelText: AppTexts.firstName),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputField),
                // last name
                TextFormField(
                  onChanged: (val) {
                    context
                        .read<AddStudentsBloc>()
                        .add(OnFamilyNameFieldChanged(val));
                  },
                  decoration: const InputDecoration(labelText: AppTexts.lastName),
                ),

                const SizedBox(height: AppSizes.spaceBtwInputField),

                /// birthday
                DatePickerField(

                  labelText: AppTexts.dateOfBirth,
                  dateController: dateController,
                  onTapped: () async {
                    final DateTime? picked =
                        await myShowDatePicker(context, selectedDate);

                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                        dateController.text = '${picked.toLocal()}'.split(' ')[0];
                      });
                      // Dispatch the event to the Bloc
                      if (context.mounted) {
                        context.read<AddStudentsBloc>().add(
                            OnDateOfBirthFieldChanged(
                                Formatter.formatDate(selectedDate)));
                      }
                    }
                  },
                ),

                const SizedBox(height: AppSizes.spaceBtwInputField),

                /// level
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(.35),
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    underline: Container(),
                    value: selectedClass.isNotEmpty ? selectedClass : null,
                    isExpanded: true,
                    hint: Padding(
                      padding: const EdgeInsets.only(left: AppSizes.defaultSpace),
                      child: Text(
                        AppTexts.chooseStudentsLevel,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
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
                              .add(const OnGetClassLevel());
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
                const SizedBox(height: AppSizes.spaceBtwSections / 2),
                const Text(AppTexts.parents),
                const SizedBox(
                  height: AppSizes.spaceBtwSections / 2,
                ),
                TextFormField(
                  onChanged: (val) {
                    context
                        .read<AddStudentsBloc>()
                        .add(OnFatherNameFieldChanged(val));
                  },
                  decoration:
                      const InputDecoration(labelText: AppTexts.fatherFirstName),
                ),

                const SizedBox(height: AppSizes.spaceBtwInputField),
                TextFormField(
                  onChanged: (val) {
                    context
                        .read<AddStudentsBloc>()
                        .add(OnMotherNameFieldChanged(val));
                  },
                  decoration:
                      const InputDecoration(labelText: AppTexts.motherFirstName),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputField),
                TextFormField(
                  onChanged: (val) {
                    context
                        .read<AddStudentsBloc>()
                        .add(OnMotherFamilyNameFieldChanged(val));
                  },
                  decoration:
                      const InputDecoration(labelText: AppTexts.motherLastName),
                ),

                const SizedBox(height: AppSizes.spaceBtwInputField),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: AppSizes.buttonWidthMedium,
                      child: OutlinedButton(
                        onPressed: widget.onCancelClicked,
                        child: const Text(AppTexts.cancel),
                      ),
                    ),
                    SizedBox(
                      width: AppSizes.buttonWidthMedium,
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<AddStudentsBloc>()
                              .add(const OnAddClicked());
                          widget.onAddClicked!();
                        },
                        child: const Text(AppTexts.validate),
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

  Future<DateTime?> myShowDatePicker(
      BuildContext context, DateTime selectedDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      // Set a minimum allowed date
      lastDate: DateTime.now(),
    );
    return picked;
  }
}
