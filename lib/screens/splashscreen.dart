import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key:key);
  @override
  _SplashScreenState createState() => _SplashScreenState();

}
class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.grey),
            )
          ]
      ),
//      body: Expanded(
//        child: Image.asset('images/splash.png')
//      ),
    );
  }
}

