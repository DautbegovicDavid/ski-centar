import 'package:flutter/material.dart';
import 'package:skicentar_desktop/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
          useMaterial3: true,
        ),
        // home: const LayoutExample(title: 'Ski Centar'),
        // home: const MyHomePage(title: 'Ski Centari BIH'),
        home: LoginPage());
  }
}
