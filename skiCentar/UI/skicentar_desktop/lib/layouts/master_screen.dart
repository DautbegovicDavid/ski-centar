import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/models/user.dart';
import 'package:skicentar_desktop/providers/theme_provider.dart';
import 'package:skicentar_desktop/providers/user_provider.dart';
import 'package:skicentar_desktop/screens/accidents_add_screen.dart';
import 'package:skicentar_desktop/screens/accidents_list_screen.dart';
import 'package:skicentar_desktop/screens/daily_weather_add_screen.dart';
import 'package:skicentar_desktop/screens/daily_weather_list_screen.dart';
import 'package:skicentar_desktop/screens/lift_add_screen.dart';
import 'package:skicentar_desktop/screens/lift_list_screen.dart';
import 'package:skicentar_desktop/screens/login_screen.dart';
import 'package:skicentar_desktop/screens/poi_add_screen.dart';
import 'package:skicentar_desktop/screens/poi_list_screen.dart';
import 'package:skicentar_desktop/screens/resort_add_screen.dart';
import 'package:skicentar_desktop/screens/resort_list_screen.dart';
import 'package:skicentar_desktop/screens/ticket_type_add_screen.dart';
import 'package:skicentar_desktop/screens/ticket_type_list_screen.dart';
import 'package:skicentar_desktop/screens/trail_add_screen.dart';
import 'package:skicentar_desktop/screens/trail_list_screen.dart';
import 'package:skicentar_desktop/screens/user_add_screen.dart';
import 'package:skicentar_desktop/screens/user_list_screen.dart';

class MasterScreen extends StatefulWidget {
  MasterScreen(this.title, this.child, this.hasBackRoute, this.showAddButton,
      {super.key});
  String title;
  bool hasBackRoute = false;
  Widget child;
  bool showAddButton = true;

  UserProvider userProvider = UserProvider();

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  late ThemeProvider themeProvider;
  User? user;

  @override
  void initState() {
    themeProvider = context.read<ThemeProvider>();
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

  void toggleShowAddButton() {
    setState(() {
      widget.showAddButton = !widget.showAddButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColorDark,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            title: Row(
              children: [
                if (widget.hasBackRoute)
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                const SizedBox(width: 8),
                Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white),
                ),
                const Spacer(),
                if (widget.showAddButton)
                  ElevatedButton(
                      onPressed: () {
                        if (widget.title == "Lifts") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LiftAddScreen()));
                        }
                        if (widget.title == "Ski Tracks") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const TrailAddScreen()));
                        }
                        if (widget.title == "Resorts") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ResortAddScreen()));
                        }
                        if (widget.title == "Users") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const UserAddScreen()));
                        }
                        if (widget.title == "Point of Interests") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const PoiAddScreen()));
                        }
                        if (widget.title == "Weather conditions") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const DailyWeatherAddScreen()));
                        }
                        if (widget.title == "Tickets") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const TicketTypeAddScreen()));
                        }
                        if (widget.title == "Accidents") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const AccidentsAddScreen()));
                        }
                      },
                      child: const Text("Add"))
              ],
            )),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
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
                                  'assets/images/logo-small.png',
                                  height: 50.0,
                                  width: 50.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Ski Centri BiH",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: Icon(
                                    themeProvider.themeMode == ThemeMode.light
                                        ? Icons.dark_mode
                                        : Icons.light_mode),
                                onPressed: () {
                                  themeProvider.toggleTheme();
                                },
                              ),
                            ],
                          ),
                          const Spacer(),
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
                          const Spacer()
                        ],
                      ),
              ),
              ListTile(
                leading: const Icon(Icons.area_chart),
                title: const Text("Resorts"),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ResortListScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.elevator_outlined),
                title: const Text("Lifts"),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LiftListScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.downhill_skiing),
                title: const Text("Ski Tracks"),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const TrailListScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.emergency),
                title: const Text("Accidents"),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const AccidentsListScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.place),
                title: const Text("Point of Interests"),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const PoiListScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.cloudy_snowing),
                title: const Text("Weather conditions"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DailyWeatherListScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.confirmation_num_rounded),
                title: const Text("Tickets"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TicketTypeListScreen()));
                },
              ),
              if(user?.userRole?.name == 'Admin')
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text("Users"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserListScreen()));
                },
              ),
              Expanded(child: Container()),
              ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: const Text("Log out"),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
        body:
            Padding(padding: const EdgeInsets.all(10.0), child: widget.child));
  }
}
