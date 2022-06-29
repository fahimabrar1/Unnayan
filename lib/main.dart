import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnayan/AlWids.dart';
import 'package:unnayan/LoginPage/model/loginpage_model.dart';
import 'package:unnayan/Services/notification_service.dart';

import 'Components/badge_model.dart';
import 'LoginPage/view/loginpage_view.dart';

Future<void> mainIni() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().whenComplete(() {
    print("completed");
  });

  await NotificationService().iniNotification();
  runApp(const MyApp());
}

void main() {
  mainIni();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginpageModel>(
          create: (context) => LoginpageModel(),
        ),
        ChangeNotifierProvider<BadgeCounter>(
          create: (context) => BadgeCounter(),
        ),
        ChangeNotifierProvider<WidContainer>(
          create: (context) => WidContainer(),
        ),
      ],
      child: MaterialApp(
        title: 'Unnayan App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: ChangeNotifierProvider<WidContainer>(
        //     create: (_)=>WidContainer(),
        //     child: const HomePageSTL()),
        //
        home: LoginPageSTL(),
        // home: Scaffold(body: LoginPageSTL()),
      ),
    );
  }
}
