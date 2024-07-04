import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/models/resort.dart';
import 'package:skicentar_mobile/models/search_result.dart';
import 'package:skicentar_mobile/providers/resort_provider.dart';
import 'package:skicentar_mobile/screens/home_screen.dart';
import 'package:skicentar_mobile/screens/poi_screen.dart';
import 'package:skicentar_mobile/screens/profile_screen.dart';
import 'package:skicentar_mobile/screens/ski_map_screen.dart';

class MasterScreen extends StatefulWidget {
  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  int _selectedIndex = 0;
  late ResortProvider resortProvider;
  SearchResult<Resort>? resortResult;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    PoiScreen(),
    SkiMapScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    resortProvider = context.read<ResortProvider>();
    _fetchData();
  }

  Future<void> _fetchData() async {
    resortResult = await resortProvider.get(filter: {});
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
      resizeToAvoidBottomInset: false, //li true
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
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
              icon: Icon(Icons.person), label: 'Profile', tooltip: "azza"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
