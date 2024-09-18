import 'export.dart';

DataColumn dataColumn(context, title, bool numeric) {
    return DataColumn(
        label: Center(
            child: customText(title, alignment: TextAlign.center,
              color: Theme.of(context).highlightColor, font: 16.0),
        ),
        numeric: numeric);
  }

  DataCell dataCell(context, text) {
    return DataCell(Center(
      child:
          customText(text, color: Theme.of(context).highlightColor, font: 16.0),
    ));
  }