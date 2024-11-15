import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/providers/daily_weather_provider.dart';
import 'package:skicentar_desktop/providers/lift_provider.dart';
import 'package:skicentar_desktop/providers/lift_type_provider.dart';
import 'package:skicentar_desktop/providers/poi_category_provider.dart';
import 'package:skicentar_desktop/providers/poi_provider.dart';
import 'package:skicentar_desktop/providers/resort_provider.dart';
import 'package:skicentar_desktop/providers/ski_accident_provider.dart';
import 'package:skicentar_desktop/providers/theme_provider.dart';
import 'package:skicentar_desktop/providers/ticket_type_provider.dart';
import 'package:skicentar_desktop/providers/ticket_type_seniority_provider.dart';
import 'package:skicentar_desktop/providers/trail_difficulty.provider.dart';
import 'package:skicentar_desktop/providers/trail_provider.dart';
import 'package:skicentar_desktop/providers/user_provider.dart';
import 'package:skicentar_desktop/providers/user_role_provider.dart';
import 'package:skicentar_desktop/screens/login_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LiftProvider()),
      ChangeNotifierProvider(create: (_) => LiftTypeProvider()),
      ChangeNotifierProvider(create: (_) => ResortProvider()),
      ChangeNotifierProvider(create: (_) => TrailDifficultyProvider()),
      ChangeNotifierProvider(create: (_) => TrailProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => UserRoleProvider()),
      ChangeNotifierProvider(create: (_) => PoiProvider()),
      ChangeNotifierProvider(create: (_) => PoiCategoryProvider()),
      ChangeNotifierProvider(create: (_) => DailyWeatherProvider()),
      ChangeNotifierProvider(create: (_) => TicketTypeProvider()),
      ChangeNotifierProvider(create: (_) => TicketTypeSeniorityProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => SkiAccidentProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
        themeMode: themeProvider.themeMode,
        home: const LoginPage());
  }
}