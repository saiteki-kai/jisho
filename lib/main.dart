import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import 'package:jisho/data/repository.dart';
import 'package:jisho/pages/search_page.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(
    MaterialApp(
      title: "Jisho",
      home: SplashScreen(),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Repository.get().init().then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SearchPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "辞書",
          style: TextStyle(
            fontFamily: "OtsutomeFont",
            color: Colors.grey[800],
            fontSize: 140.0,
          ),
        ),
      ),
    );
  }
}
