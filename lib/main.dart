import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pietycustomer/BloCLayer/StoreBlocV2.dart';
import 'package:pietycustomer/DataLayer/Models/StoreModels/RateList.dart';
import 'package:pietycustomer/UILayer/Screens/HomeScreens/HomePage.dart';
import 'package:pietycustomer/UILayer/Screens/StoreDescriptionScreens/StoreDescriptionScreenV2.dart';
import '../BloCLayer/AdminBloc.dart';
import '../DataLayer/Services/HandleSignIn.dart';
import '../DataLayer/Services/cloudMessaging.dart';
import '../DataLayer/Services/connectivityService.dart';
import '../DataLayer/Services/notificationHandler.dart';
import '../const.dart';
import 'package:provider/provider.dart';

import 'BloCLayer/ChatBloc.dart';
import 'BloCLayer/OrderBloc.dart';
import 'BloCLayer/UserBloc.dart';
import 'DataLayer/Models/Other/Enums.dart';
import 'UILayer/Screens/HomeScreens/HomeScreen.dart';
import 'UILayer/Screens/LandingScreen.dart';
import 'UILayer/Screens/SettingsScreens/SettingsScreen.dart';
import 'UILayer/Screens/StoreDescriptionScreens/StoreDescriptionScreen.dart';
import 'UILayer/Screens/StoreDescriptionScreens/StoreDescriptionScreen_v2.dart';
import 'UILayer/Screens/StoreDescriptionScreens/StoresDescriptionScreenV3.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  NotificationHandler _notificationHandler = NotificationHandler();
  CloudMessaging _cloudMessaging =
      CloudMessaging.withNotification(_notificationHandler);
  Constants.fcmToken = await _cloudMessaging.getToken();
  print("FCM TOKEN: ${Constants.fcmToken}");
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      initialData: ConnectivityStatus.online,
      create: (BuildContext context) =>
          ConnectivityService().connectionStatusController.stream,
      child: BlocProvider<AdminBloc>(
        bloc: AdminBloc(),
        child: BlocProvider(
          bloc: ChatBloc(),
          child: BlocProvider<UserBloc>(
            bloc: UserBloc.initialize(),
            child: BlocProvider<StoreBloc>(
              bloc: StoreBloc.initialize(),
              child: BlocProvider<OrderBloc>(
                bloc: OrderBloc(),
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Suvidha',
                  theme: ThemeData(
                      primarySwatch: Colors.blue,
                      textTheme: GoogleFonts.dmSansTextTheme()),
                  home:HandleSignIn(),
                  //HandleSignIn(),
                  routes: {
                    Home.route:(context) => Home(),
                    LandingScreen.route: (context) => LandingScreen(),
                    HomeScreen.route: (context) => HomeScreen(),
                    SettingsScreen.route: (context) => SettingsScreen(),
                  //   CheckoutScreen.route: (context) => CheckoutScreen(),
                   //  ServicesScreen.route: (context) => ServicesScreen(),
                    StoreDescriptionScreen.route: (context) =>
                        StoreDescription(),
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
