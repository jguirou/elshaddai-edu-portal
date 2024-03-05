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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.35),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.black45),
        ),
        style: const TextStyle(color: Colors.black),
        controller: widget.dateController,
        readOnly: true,
        onTap: widget.onTapped,
      ),
    );
  }
}
