import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ipos/data/themeChanger.dart';
import 'package:ipos/screens/homeScreen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize().then((InitializationStatus status) {
    print('Initialization done: ${status.adapterStatuses}');
    MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(
          tagForChildDirectedTreatment:
              TagForChildDirectedTreatment.unspecified,
          testDeviceIds: <String>[]),
    );
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IPO Cart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("${notification.title}"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("${notification.body}")],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification() {
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "Alert",
        "Updated GMP Details",
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  Widget build(BuildContext context) {
    return ThemeChanger(builder: (context, _brightness) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IPO Cart',
        theme: ThemeData(
          brightness: _brightness,
          primarySwatch: Colors.green,
        ),
        home: FutureBuilder(
          future: checkNet(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Somthing went wrong");
            }

            if (snapshot.data == ConnectivityResult.none) {
              return Scaffold(
                  body: Center(
                child: Text(
                    "No Internet Connection! Check your connection and please try again"),
              )); //HomeScreen();
            } else {
              return FutureBuilder(
                  future: checkNet(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Somthing went wrong");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return HomeScreen();
                    } else {
                      return Scaffold(body: CircularProgressIndicator());
                    }
                  });
            }
          },
        ),
      );
    });
  }

  checkNet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) ||
        (connectivityResult == ConnectivityResult.wifi)) {
      return connectivityResult;
    } else if (connectivityResult == ConnectivityResult.none) {
      return connectivityResult;
    }
  }
}
