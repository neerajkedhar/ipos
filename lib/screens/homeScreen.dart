import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ipos/data/themeChanger.dart';
import 'package:ipos/data/uicolors.dart';
import 'package:ipos/icons/flutter_menu_icons.dart';
import 'package:ipos/screens/iponews.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:ipos/screens/listedIPOs.dart';
import 'package:ipos/screens/liveIPOs.dart';
import 'package:ipos/screens/news.dart';

import 'package:ipos/screens/webopen.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import '../getData.dart';

const _url =
    'https://play.google.com/store/apps/details?id=com.kedhar.ipo_cart';
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);

void _launchURL() async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("a msg from firebasecjust showed up: ${message.messageId}");
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences? prefs;
  final String key = "Term&conditions";
  bool isTnCAccepted = false;
  late Color background;
  late Color foreground;
  late Color accent;
  AppColors colors = AppColors();
  late TabController _controller;
  late bool themeNow;
  late Color mainText;
  late Color subText;
  BannerAd? _anchoredBanner;
  BannerAd? banner;
  bool? isLoading;

  @override
  void initState() {
    super.initState();
    initPrefs();
    fb();
    _controller = TabController(length: 3, vsync: this);
    _createAnchoredBanner();
  }

  Future<void> _createAnchoredBanner() async {
    final AdSize adSize = AdSize(height: 50, width: 330);

    final BannerAd banner = BannerAd(
      size: adSize,
      request: AdRequest(),
      adUnitId:
          'ca-app-pub-3071933490034842/5207120991', //'ca-app-pub-3940256099942544/6300978111',
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            _anchoredBanner = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }

  @override
  void dispose() {
    super.dispose();

    _anchoredBanner?.dispose();
  }

  fb() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  saveToPrefs(bool val) async {
    await initPrefs();
    prefs!.setBool(key, val);
  }

  alert() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: background,
            title: Text('Disclaimer'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    child: Text(
                      "Any financial information or ideas published anywhere within this application, should not be considered as an advice to buy or sell securities or invest in IPOs. All matter published here is purely for education and information purpose only. All the infomation published in this application is gathered from the internet and other news publications, so the information here may not be accurate and under no circumstances you should use this information to make investment decisions. \n \n We are not SEBI egistered analyst. App users must consult a qualified financial advisor prior to making actual investment or financial decisions, \n \n YOUR USE OF THE APP AND YOUR RELIANCE ON ANY INFORMATION ON THE App IS SOLELY AT YOUR OWN RISK. \n \n by clicking on agree, you agree to the Terms and Conditions to use this Application.",
                      style: TextStyle(color: subText),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    child: Text(
                      "External Links Disclaimer",
                      style: TextStyle(color: mainText, fontSize: 20),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    child: Text(
                      "The App may contain (or you may be sent through the Site) links to other websites or content belonging to or originating from third parties or links to websites and features. Such external links are not investigated, monitored, or checked for accuracy, adequacy, validity, reliability, availability or completeness by us. \n \n WE DO NOT WARRANT, ENDORSE, GUARANTEE, OR ASSUME RESPONSIBILITY FOR THE ACCURACY OR RELIABILITY OF ANY INFORMATION OFFERED BY THIRD-PARTY WEBSITES LINKED THROUGH THE SITE OR ANY WEBSITE OR FEATURE LINKED IN ANY BANNER OR OTHER ADVERTISING. WE WILL NOT BE A PARTY TO OR IN ANY WAY BE RESPONSIBLE FOR MONITORING ANY TRANSACTION BETWEEN YOU AND THIRD-PARTY PROVIDERS OF PRODUCTS OR SERVICES. \n \n by clicking on agree, you agree with the Terms and Conditions to use this Application.",
                      style: TextStyle(color: subText),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ElevatedButton(
                            child: Text('I Agree'),
                            onPressed: () {
                              saveToPrefs(true);
                              Navigator.of(context).pop();
                            }),
                        // ElevatedButton(
                        //     child: Text('Decline'),
                        //     onPressed: () {
                        //       Navigator.of(context).pop();
                        //     })
                      ])
                ],
              ),
            ),
          );
        });
  }

  initPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
      isTnCAccepted = prefs!.getBool(key) ?? false;
      if (!isTnCAccepted) {
        alert();
      } else {}
    }
  }

  var width;
  @override
  Widget build(BuildContext context) {
    setState(() {
      width = MediaQuery.of(context).size.width;
    });
    themeNow = Theme.of(context).brightness == Brightness.dark ? true : false;
    background = Theme.of(context).brightness == Brightness.dark
        ? colors.darkBG
        : colors.liteBG;
    foreground = Theme.of(context).brightness == Brightness.dark
        ? colors.darkFG
        : colors.liteFG;
    accent = Theme.of(context).brightness == Brightness.dark
        ? colors.accent
        : colors.accentL;
    mainText = Theme.of(context).brightness == Brightness.dark
        ? colors.darkmaintext
        : colors.litemaintext;
    subText = Theme.of(context).brightness == Brightness.dark
        ? colors.darksubtext
        : colors.litesubtext;
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawer(),
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        title: Text(
          "IPO Cart",
          style: TextStyle(color: mainText),
        ),
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(
              FlutterMenu.union_50,
              size: 10,
              color: mainText,
            )),
        bottom: TabBar(
          labelColor: accent,
          indicatorColor: accent,
          controller: _controller,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          tabs: [
            Tab(text: "Live IPOs"),
            Tab(text: "Listed IPOs"),
            Tab(text: "IPO News")
          ],
        ),
      ),
      body: Stack(children: [
        TabBarView(
          controller: _controller,
          children: [LiveIPO(), ListedIPO(), IPONews()],
        ),
        if (_anchoredBanner != null)
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              color: background,
              width: _anchoredBanner!.size.width.toDouble(),
              height: _anchoredBanner!.size.height.toDouble(),
              child: AdWidget(ad: _anchoredBanner!),
            ),
          ),
      ]),
    );
  }

  Widget drawer() {
    return Drawer(
      child: Container(
        color: background,
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(children: [
                  SizedBox(height: 80),
                  Image.asset(
                    "lib/assets/ic_launcher.png",
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(width: 20),
                  RichText(
                      text: TextSpan(
                          text: "IPO",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                        TextSpan(
                          text: " Cart",
                          style: TextStyle(
                            fontSize: 25,
                            color: mainText,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ])),
                ]),
              ),
            ),
            ListTile(
              leading: themeNow
                  ? Icon(Icons.dark_mode_rounded)
                  : Icon(Icons.wb_sunny_rounded),
              title: Text("Dark Mode"),
              trailing: Switch(
                value: themeNow,
                onChanged: (bool value) {
                  ThemeChanger.of(context)!.changeTheme();
                  themeNow = value;
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_rounded),
              title: Text("Privacy Policy"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Webopen(
                          "https://kedhar-app-development-studios.github.io/Privacy-Policy/")),
                );
              },
            ),
            ListTile(
                leading: Icon(Icons.report_rounded),
                title: Text("Desclaimer"),
                onTap: () {
                  alert();
                }),
            ListTile(
                leading: Icon(Icons.feedback_rounded),
                title: Text("Feedback"),
                onTap: () => _launchURL()),
            ListTile(
                leading: Icon(Icons.star_rounded),
                title: Text("Rate Us"),
                onTap: () => _launchURL()),
            ListTile(
                leading: Icon(Icons.ios_share_rounded),
                title: Text("Share"),
                onTap: () => Share.share(_url)),
          ],
        ),
      ),
    );
  }
}
