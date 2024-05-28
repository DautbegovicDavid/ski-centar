import 'package:flutter/material.dart';
import 'package:skicentar_desktop/screens/lift_list_screen.dart';
import 'package:skicentar_desktop/screens/user_list_screen.dart';

class MasterScreen extends StatefulWidget {
  MasterScreen(this.title, this.child, {super.key});
  String title;
  Widget child;

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text("Back"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Lifts"),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute( // pushReplacement
                      builder: (context) => LiftListScreen()));
                },
              ),
              ListTile(
                title: const Text("Users"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserListScreen()));
                },
              )
            ],
          ),
        ),
        body: widget.child);
  }
}
