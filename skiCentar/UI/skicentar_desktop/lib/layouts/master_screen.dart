import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:skicentar_desktop/models/user.dart';
import 'package:skicentar_desktop/providers/user_provider.dart';
import 'package:skicentar_desktop/screens/lift_list_screen.dart';
import 'package:skicentar_desktop/screens/login_screen.dart';
import 'package:skicentar_desktop/screens/resort_list_screen.dart';
import 'package:skicentar_desktop/screens/user_list_screen.dart';

class MasterScreen extends StatefulWidget {
  MasterScreen(this.title, this.child, this.hasBackRoute, {super.key});
  String title;
  bool hasBackRoute = false;
  Widget child;

  UserProvider userProvider = UserProvider();

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      final fetchedUser = await widget.userProvider.getDetails();
      setState(() {
        user = fetchedUser;
      });
    } catch (e) {
      print('Failed to load user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Row(
              children: [
                if (widget.hasBackRoute)
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_sharp),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                SizedBox(width: 8),
                Text(
                  widget.title,
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                ElevatedButton(onPressed: () => {}, child: Text("Add"))
              ],
            )),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: user == null
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  'assets/images/logo-small.png', // Path to your custom image
                                  height: 50.0,
                                  width: 50.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 8),
                              const Text(
                                "Ski Centri BiH",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            '${user!.email}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${user!.userRole!.name}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Spacer()
                        ],
                      ),
              ),
              ListTile(
                leading: const Icon(Icons.area_chart),
                title: const Text("Resorts"),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ResortListScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.elevator_outlined),
                title: const Text("Lifts"),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => LiftListScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.downhill_skiing),
                title: const Text("Ski Tracks"),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => LiftListScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text("Users"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserListScreen()));
                },
              ),
              Expanded(child: Container()),
              ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: const Text("Log out"),
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ),
        body:
            Padding(padding: const EdgeInsets.all(10.0), child: widget.child));
  }
}
