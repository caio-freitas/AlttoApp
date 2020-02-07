import 'package:altto_app/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:altto_app/screens/config.dart';
import 'package:altto_app/screens/mainscreen.dart';

void main() => runApp(MyApp());
//void main() => runApp(new MaterialApp(
//    theme:
//      ThemeData(primaryColor: Colors.red, accentColor: Colors.yellowAccent),
//    debugShowCheckedModeBanner: false,
//    home: SplashScreen(),
//  ));



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Altto',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Marvel',
      ),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/config': (context) => Config(),
      },
//      home: SplashScreen(),
//      debugShowCheckedModeBanner: false,
    );
  }
}
