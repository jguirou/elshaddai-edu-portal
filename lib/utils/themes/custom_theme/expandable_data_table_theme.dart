import 'package:flutter/material.dart';
import 'package:expandable_datatable/expandable_datatable.dart';


class ExpandableCustomTheme {
  static ExpandableThemeData lightExpandableTheme(BuildContext context) => ExpandableThemeData(
    context,
    contentPadding: const EdgeInsets.all(20),
    expandedBorderColor: Colors.transparent,
    paginationSize: 48,
    headerHeight: 56,
    headerColor: Colors.amber[400],
    headerBorder: const BorderSide(
      color: Colors.black,
      width: 1,
    ),
    evenRowColor: const Color(0xFFFFFFFF),
    oddRowColor: Colors.amber[100],
    rowBorder: const BorderSide(
      color: Colors.black,
      width: 0.3,
    ),
    headerTextStyle: Theme.of(context).textTheme.labelMedium!.apply(overflow: TextOverflow.ellipsis ),
    expandedTextStyle:Theme.of(context).textTheme.labelMedium!.apply( overflow: TextOverflow.ellipsis ) ,
    rowTextStyle: Theme.of(context).textTheme.titleSmall!.apply(overflow: TextOverflow.ellipsis ),
    rowColor: Colors.green,
    headerTextMaxLines:1,
    rowTextMaxLines: 1,

    headerSortIconColor: Colors.blue,
    paginationSelectedFillColor: Colors.blue,
    paginationSelectedTextColor: Colors.white,
  );

  static ExpandableThemeData darkExpandableTheme(BuildContext context) => ExpandableThemeData(
    context,
    contentPadding: const EdgeInsets.all(20),
    expandedBorderColor: Colors.transparent,
    paginationSize: 48,
    headerHeight: 56,
    headerColor: Colors.amber[700],
    headerBorder: const BorderSide(
      color: Colors.white,
      width: 1,
    ),
    evenRowColor: const Color(0xFF333333),
    oddRowColor: Colors.amber[800],
    rowBorder: const BorderSide(
      color: Colors.white,
      width: 0.3,
    ),
    rowColor: Colors.green[800],
    headerTextMaxLines: 4,
    headerSortIconColor: Colors.blue[300],
    paginationSelectedFillColor: Colors.blue[800],
    paginationSelectedTextColor: Colors.black,
  );
}

