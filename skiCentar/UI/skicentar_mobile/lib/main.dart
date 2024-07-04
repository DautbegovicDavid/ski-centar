import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/providers/daily_weather_provider.dart';
import 'package:skicentar_mobile/providers/lift_provider.dart';
import 'package:skicentar_mobile/providers/poi_category_provider.dart';
import 'package:skicentar_mobile/providers/poi_provider.dart';
import 'package:skicentar_mobile/providers/resort_provider.dart';
import 'package:skicentar_mobile/providers/ticket_type_provider.dart';
import 'package:skicentar_mobile/providers/trail_provider.dart';
import 'package:skicentar_mobile/providers/user_detail_provider.dart';
import 'package:skicentar_mobile/providers/user_provider.dart';
import 'package:skicentar_mobile/screens/login_screen.dart';
import 'package:skicentar_mobile/screens/user_verified_screen.dart';

void main() {
   runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LiftProvider()),
      ChangeNotifierProvider(create: (_) => ResortProvider()),
      ChangeNotifierProvider(create: (_) => DailyWeatherProvider()),
      ChangeNotifierProvider(create: (_) => TicketTypeProvider()),
      ChangeNotifierProvider(create: (_) => PoiProvider()),
      ChangeNotifierProvider(create: (_) => PoiCategoryProvider()),
      ChangeNotifierProvider(create: (_) => TrailProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => UserDetailProvider()),
    ],
    child: const MyApp(),
  ));
}

class LiftTypeProvider {
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    initDeepLinks();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    print(_navigatorKey.currentState);
    _navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserVerifiedPage(),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
