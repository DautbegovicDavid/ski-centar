// import 'dart:math';

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           // This is the theme of your application.
//           //
//           // TRY THIS: Try running your application with "flutter run". You'll see
//           // the application has a blue toolbar. Then, without quitting the app,
//           // try changing the seedColor in the colorScheme below to Colors.green
//           // and then invoke "hot reload" (save your changes or press the "hot
//           // reload" button in a Flutter-supported IDE, or press "r" if you used
//           // the command line to start the app).
//           //
//           // Notice that the counter didn't reset back to zero; the application
//           // state is not lost during the reload. To reset the state, use hot
//           // restart instead.
//           //
//           // This works for code too, not just values: Most code changes can be
//           // tested with just a hot reload.
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
//           useMaterial3: true,
//         ),
//         // home: const LayoutExample(title: 'Ski Centar'),
//         // home: const MyHomePage(title: 'Ski Centari BIH'),
//         home: const LoginPage());
//   }
// }

// class LayoutExample extends StatelessWidget {
//   const LayoutExample({super.key, required String title});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//             height: 200,
//             color: Colors.red,
//             child: Center(
//               child: Container(
//                 height: 100,
//                 // width: 50,
//                 color: Colors.blue,
//                 child: const Text('wazza'),
//               ),
//             )),
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("1"),
//             Text("2"),
//             Text("3"),
//           ],
//         ),
//         Container(
//           height: 150,
//           color: Colors.blue,
//           child: Center(child: Text("contain")),
//         )
//       ],
//     );
//   }
// }

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("waza"),
//         ),
//         body: Center(
//           child: Center(
//               child: Container(
//                   constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
//                   child: Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Column(children: [
//                         ClipRRect(
//                           borderRadius:
//                               BorderRadius.circular(20), // Image border
//                           child: SizedBox.fromSize(
//                             size: Size.fromRadius(48), // Image radius
//                             child: Image.network(
//                                 'https://static.vecteezy.com/system/resources/previews/000/623/284/non_2x/mountain-logo-vector-illustration.jpg',
//                                 fit: BoxFit.cover),
//                           ),
//                         ),
//                         Container(
//                             height: 200,
//                             child: const Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 TextField(
//                                   decoration: InputDecoration(
//                                       labelText: "Username",
//                                       suffixIcon: Icon(Icons.email)),
//                                 ),
//                                 TextField(
//                                   decoration: InputDecoration(
//                                       labelText: "Password",
//                                       suffixIcon: Icon(Icons.password)),
//                                 )
//                               ],
//                             )),
//                         ElevatedButton(
//                             style: ButtonStyle(),
//                             onPressed: () {
//                               print("LOGIN ATTEMPT");
//                             },
//                             child: Text("LOGIN"))
//                       ]),
//                     ),
//                   ))),
//         ));
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }


import 'dart:async';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'url_protocol/api.dart';

///////////////////////////////////////////////////////////////////////////////
/// Please make sure to follow the setup instructions below
///
/// Please take a look at:
/// - example/android/app/main/AndroidManifest.xml for Android.
///
/// - example/ios/Runner/Runner.entitlements for Universal Link sample.
/// - example/ios/Runner/Info.plist for Custom URL scheme sample.
///
/// You can launch an intent on an Android Emulator like this:
///    adb shell am start -a android.intent.action.VIEW \
///     -d "sample://open.my.app/#/book/hello-world"
///
///
/// On windows & macOS:
///   The simplest way to test it is by
///   opening your browser and type: sample://foo/#/book/hello-world2
///////////////////////////////////////////////////////////////////////////////

const kWindowsScheme = 'sample';

void main() {
  // Register our protocol only on Windows platform
  _registerWindowsProtocol();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();

    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();

    super.dispose();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Handle links
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      print('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    _navigatorKey.currentState?.pushNamed(uri.fragment);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        Widget routeWidget = defaultScreen();

        // Mimic web routing
        final routeName = settings.name;
        if (routeName != null) {
          if (routeName.startsWith('/book/')) {
            // Navigated to /book/:id
            routeWidget = customScreen(
              routeName.substring(routeName.indexOf('/book/')),
            );
          } else if (routeName == '/book') {
            // Navigated to /book without other parameters
            routeWidget = customScreen("None");
          }
        }

        return MaterialPageRoute(
          builder: (context) => routeWidget,
          settings: settings,
          fullscreenDialog: true,
        );
      },
    );
  }

  Widget defaultScreen() {
    return Scaffold(
      appBar: AppBar(title: const Text('Default Screen')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SelectableText('''
            Launch an intent to get to the second screen.

            On web:
            http://localhost:<port>/#/book/1 for example.

            On windows & macOS, open your browser:
            sample://foo/#/book/hello-deep-linking

            This example code triggers new page from URL fragment.
            '''),
            const SizedBox(height: 20),
            buildWindowsUnregisterBtn(),
          ],
        ),
      ),
    );
  }

  Widget customScreen(String bookId) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(child: Text('Opened with parameter: $bookId')),
    );
  }

  Widget buildWindowsUnregisterBtn() {
    if (!kIsWeb) {
      if (Platform.isWindows) {
        return TextButton(
            onPressed: () => print("wazza"),
            child: const Text('Remove Windows protocol registration'));
      }
    }

    return const SizedBox.shrink();
  }
}

void _registerWindowsProtocol() {
  // Register our protocol only on Windows platform
  if (!kIsWeb) {
    if (Platform.isWindows) {
      print("wazza");
    }
  }
}
