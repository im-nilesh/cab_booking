import 'package:flutter/material.dart';

class CustomDataTable extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final double maxWidth;

  const CustomDataTable({
    Key? key,
    required this.columns,
    required this.rows,
    this.maxWidth = 1200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: DataTable(
            headingRowHeight: 50,
            dataRowHeight: 60,
            columnSpacing: 30,
            dividerThickness: 0.6,
            headingRowColor: MaterialStateProperty.all(
              Colors.green.withOpacity(0.1),
            ),
            dataRowColor: MaterialStateProperty.resolveWith(
              (states) =>
                  states.contains(MaterialState.selected)
                      ? Colors.green.withOpacity(0.05)
                      : Colors.transparent,
            ),
            border: TableBorder(
              horizontalInside: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 0.7,
              ),
            ),
            columns: columns,
            rows: rows,
          ),
        ),
      ),
    );
  }
}
