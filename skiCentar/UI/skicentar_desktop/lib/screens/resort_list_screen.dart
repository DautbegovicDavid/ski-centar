import 'package:flutter/material.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/resort.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/providers/resort_provider.dart';

class ResortListScreen extends StatefulWidget {
  const ResortListScreen({super.key});

  @override
  State<ResortListScreen> createState() => _ResortListScreenState();
}

class _ResortListScreenState extends State<ResortListScreen> {
  SearchResult<Resort>? result = null;
  
  ResortProvider provider = ResortProvider();

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Resorts",
        Container(
            child: Column(
          children: [_buildSearch(), _buildResultView()],
        )),
        true
        );
  }

  TextEditingController _ftsEditingController = TextEditingController();
  TextEditingController _sifraController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    result = await provider.get(filter: null);
          setState(() {
      });
  }

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
                DataColumn(label: Text("Id"), numeric: true),
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Location - City")),
                DataColumn(label: Text("Elevation (m)")),
                DataColumn(label: Text("SKI work hours")),


              ],
              rows: result?.result
                      .map((m) => DataRow(cells: [
                            DataCell(Text(m.id.toString())),
                            DataCell(Text(m.name!)),
                            DataCell(Text(m.location!)),
                            DataCell(Text(m.elevation!.toString())),
                            DataCell(Text(m.skiWorkHours!)),
                          ]))
                      .toList()
                      .cast<DataRow>() ??
                  [],
            ),
          )),
    );
  }
}
