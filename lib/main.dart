import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:jisho/data/repository.dart';
import 'package:jisho/pages/list_page.dart';
import 'package:jisho/pages/history_page.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(new MainPage());
}

class MainPage extends StatefulWidget {
  HomePage createState() => HomePage();
}

class HomePage extends State<MainPage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _widgetOptions = <Widget>[
    ListPage(),
    HistoryPage(),
    Scaffold(
      appBar: new AppBar(
          title: Text('Jisho'),
          backgroundColor: Colors.red[400]
      ),
      body: Center(
        child: Text(
          'Index 2: Favorites',
          style: optionStyle,
        ),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Repository.get().init(); // could handle init state
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jisho',
      home: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text('History'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Favorites'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red[400],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
