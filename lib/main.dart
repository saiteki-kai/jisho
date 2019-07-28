import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import 'package:jisho/data/app_database.dart';
import 'package:jisho/pages/home_page.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MaterialApp(
    home: SplashScreen(),
    title: "Jisho",
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future initDB() => AppDatabase.instance.database;

  @override
  void initState() {
    super.initState();

    initDB().then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("ciao"),
      ),
    );
  }
}
