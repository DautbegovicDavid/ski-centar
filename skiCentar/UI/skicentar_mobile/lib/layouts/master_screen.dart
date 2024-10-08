import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/models/resort.dart';
import 'package:skicentar_mobile/models/search_result.dart';
import 'package:skicentar_mobile/providers/resort_provider.dart';
import 'package:skicentar_mobile/providers/user_provider.dart';
import 'package:skicentar_mobile/screens/home_screen.dart';
import 'package:skicentar_mobile/screens/manage_lift_screen.dart';
import 'package:skicentar_mobile/screens/manage_track_screen.dart';
import 'package:skicentar_mobile/screens/poi_screen.dart';
import 'package:skicentar_mobile/screens/profile_screen.dart';
import 'package:skicentar_mobile/screens/ski_accidents_screen.dart';
import 'package:skicentar_mobile/screens/ski_map_screen.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  int _selectedIndex = 0;
  late ResortProvider resortProvider;
  SearchResult<Resort>? resortResult;

  final List<Widget> _endUserWidgetOptions = <Widget>[
    const HomeScreen(),
    const PoiScreen(),
    const SkiMapScreen(),
    const ProfileScreen(),
  ];

  final List<Widget> _employeeWidgetOptions = <Widget>[
    const SkiAccidentsScreen(),
    const ManageLiftScreen(),
    const ManageTracksScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    resortProvider = context.read<ResortProvider>();
    _fetchData();
  }

  Future<void> _fetchData() async {
    resortResult = await resortProvider.get(filter: {});
    if (resortProvider.selectedResort == null) {
      resortProvider.selectResort(resortResult!.result.first);
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    final isEmployee = userProvider.currentUser?.userRole?.name == 'Employee' ||
        userProvider.currentUser?.userRole?.name == 'Admin';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Consumer<ResortProvider>(
          builder: (context, resortProvider, child) {
            return resortResult == null
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Resort: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        DropdownButton<Resort>(
                          value: resortProvider.selectedResort,
                          hint: const Text('Select Resort'),
                          onChanged: (Resort? newResort) {
                            if (newResort != null) {
                              resortProvider.selectResort(newResort);
                            }
                          },
                          items: resortResult!.result.map((Resort resort) {
                            return DropdownMenuItem<Resort>(
                              value: resort,
                              child: Text(resort.name.toString()),
                            );
                          }).toList(),
                        ),
                      ],
                    ));
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: _selectedIndex,
        children: isEmployee ? _employeeWidgetOptions : _endUserWidgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: isEmployee
            ? const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.emergency),
                  label: 'Accidents',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.elevator),
                  label: 'Lifts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.downhill_skiing),
                  label: 'Tracks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ]
            : const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore),
                  label: 'POI',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.downhill_skiing_outlined),
                  label: 'Ski Map',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
