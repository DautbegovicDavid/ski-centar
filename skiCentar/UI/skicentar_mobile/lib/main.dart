import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/providers/daily_weather_provider.dart';
import 'package:skicentar_mobile/providers/lift_provider.dart';
import 'package:skicentar_mobile/providers/payment_provider.dart';
import 'package:skicentar_mobile/providers/poi_category_provider.dart';
import 'package:skicentar_mobile/providers/poi_provider.dart';
import 'package:skicentar_mobile/providers/resort_provider.dart';
import 'package:skicentar_mobile/providers/ski_accident_provider.dart';
import 'package:skicentar_mobile/providers/ticket_provider.dart';
import 'package:skicentar_mobile/providers/ticket_type_provider.dart';
import 'package:skicentar_mobile/providers/trail_provider.dart';
import 'package:skicentar_mobile/providers/user_detail_provider.dart';
import 'package:skicentar_mobile/providers/user_poi_provider.dart';
import 'package:skicentar_mobile/providers/user_provider.dart';
import 'package:skicentar_mobile/providers/weather_provider.dart';
import 'package:skicentar_mobile/screens/login_screen.dart';
import 'package:skicentar_mobile/screens/user_verified_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/config/.env");
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

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
      ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ChangeNotifierProvider(create: (_) => PaymentProvider()),
      ChangeNotifierProvider(create: (_) => TicketProvider()),
      ChangeNotifierProvider(create: (_) => SkiAccidentProvider()),
      ChangeNotifierProvider(create: (_) => UserPoiProvider()),
    ],
    child: const MyApp(),
  ));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

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
    requestNotificationPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showNotification(message);
      }
    });

    FirebaseMessaging.instance.subscribeToTopic('allDevices').then((_) {
      print('Subscribed to allDevices topic');
    });

    initDeepLinks();
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'ski_center',
      'ski_center_accidents',
      channelDescription: 'Notifications for ski updates and alerts',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    String verificationToken = uri.queryParameters['id'] ?? '';
    _navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            UserVerifiedPage(verificationLink: verificationToken),
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
