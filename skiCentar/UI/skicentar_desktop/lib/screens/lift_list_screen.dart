import 'package:flutter/material.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';

class LiftListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MasterScreen(
        "Lifts",
        Column(children: [
          Text("LISTA PROIZVODA"),
          SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () => Navigator.pop(context), child: Text("NAZAD"))
        ]));
  }
}
