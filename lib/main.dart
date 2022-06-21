import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnayan/LoginPage/model/loginpage_model.dart';
import 'package:unnayan/Services/notification_service.dart';

import 'Components/badge_model.dart';
import 'LoginPage/view/loginpage_view.dart';

Future<void> mainIni() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp().whenComplete(() {
  //
  //   print("completed");
  //
  //
  // });

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
      ],
      child: MaterialApp(
        title: 'Unnayan App',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
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
