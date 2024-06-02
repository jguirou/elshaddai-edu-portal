import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField(
      {super.key,
      this.fieldKey,
      this.hintText,
      this.labelText,
      required this.dateController,
      required this.onTapped});

  final Key? fieldKey;
  final TextEditingController dateController;
  final void Function()? onTapped;

  final String? hintText;
  final String? labelText;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.labelText ,
        prefixIcon: const Icon(Icons.date_range),
      ),

      controller: widget.dateController,
      readOnly: true,
      onTap: widget.onTapped,
    );
  }
}
