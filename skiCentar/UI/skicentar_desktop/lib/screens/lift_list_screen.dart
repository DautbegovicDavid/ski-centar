import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/lift.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/providers/lift_provider.dart';

class LiftListScreen extends StatefulWidget {
  const LiftListScreen({super.key});

  @override
  State<LiftListScreen> createState() => _LiftListScreenState();
}

class _LiftListScreenState extends State<LiftListScreen> {
  SearchResult<Lift>? result = null;
  // LiftProvider provider = new LiftProvider();

  late LiftProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    provider = context.read<LiftProvider>();

    provider.get(filter: {});
  }


  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Lifts",
        Container(
            child: Column(
          children: [_buildSearch(), _buildResultView()],
        )),
        false);
  }

  TextEditingController _ftsEditingController = TextEditingController();
  TextEditingController _sifraController = TextEditingController();

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _ftsEditingController,
            decoration: InputDecoration(labelText: "Name"),
          )),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: TextField(
            controller: _sifraController,
            decoration: InputDecoration(labelText: "Šifra"),
          )),
          ElevatedButton(
              onPressed: () async {
                var filter = {
                  'NameGTE': _ftsEditingController.text,
                  'sifra': _sifraController.text
                };
                result = await provider.get(filter: filter);
                setState(() {});

                //todo call api
              },
              child: Text("Search")),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
              onPressed: () async => {
                    //todo call api
                  },
              child: Text("Add"))
        ],
      ),
    );
  }

  Widget _buildResultView() {
    return Expanded(
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            child: DataTable(
              columns: [
                DataColumn(label: Text("ID"), numeric: true),
                DataColumn(label: Text("NAME")),
                DataColumn(label: Text("Functional"))
              ],
              rows: result?.result
                      .map((m) => DataRow(cells: [
                            DataCell(Text(m.id.toString())),
                            DataCell(Text(m.name!)),
                            DataCell(Text(m.isFunctional != null
                                ? m.isFunctional == true
                                    ? "Yes"
                                    : "No"
                                : "Not Active")),
                          ]))
                      .toList()
                      .cast<DataRow>() ??
                  [],
            ),
          )),
    );
  }
}
