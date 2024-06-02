
import 'package:flutter/material.dart';
import 'package:expandable_datatable/expandable_datatable.dart';

import '../../../../utils/themes/custom_theme/expandable_data_table_theme.dart';

class MyExpandableDataTable extends StatefulWidget {
  const MyExpandableDataTable(
      {super.key,
        required this.child});
  final ExpandableDataTable child;



  @override
  State<MyExpandableDataTable> createState() =>
      _MyExpandableDataTableState();
}

class _MyExpandableDataTableState
    extends State<MyExpandableDataTable> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final expandableTheme = theme.brightness == Brightness.light
        ? ExpandableCustomTheme.lightExpandableTheme(context)
        : ExpandableCustomTheme.darkExpandableTheme(context);

    return ExpandableTheme(
      key: UniqueKey(),
      data: expandableTheme,
      child: widget.child,
    );
  }



}

// Helper function to extract cell values dynamically
T? getCellValue<T>(ExpandableRow row, int index) {
  try {
    // Try to cast the value to the specified type
    return row.cells[index].value as T?;
  } catch (e) {
    // Handle any potential errors during casting
    return null;
  }
}
