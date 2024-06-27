import 'package:flutter/material.dart';

class TableWrapper extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;

  const TableWrapper({
    Key? key,
    required this.columns,
    required this.rows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            elevation: 2.0,
            margin: const EdgeInsets.all(10.0),
          surfaceTintColor: Colors.white,
            child: Container(
              width: double.infinity,
              child: DataTable(
                columns: columns,
                rows: rows,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
