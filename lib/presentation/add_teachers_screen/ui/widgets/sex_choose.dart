import 'package:flutter/material.dart';

class SexChoose extends StatelessWidget {
  final List<String> gender;
  final String? selectedGender;
  final Function onChanged;

  const SexChoose(
      {super.key,
      required this.selectedGender,
      required this.onChanged,
      required this.gender});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Sexe:"),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: gender.map((genderItem) {
                return Row(
                  children: [
                    Radio<String>(
                      value: genderItem,
                      groupValue: selectedGender,
                      onChanged: (value) {
                        onChanged(value);
                      },
                    ),
                    Text(genderItem),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
