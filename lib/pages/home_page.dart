import 'package:flutter/material.dart';

import 'package:jisho/pages/search_page.dart';
import 'package:jisho/pages/history_page.dart';
import 'package:jisho/pages/favorites_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho/bloc/word_bloc.dart';
import 'package:jisho/pages/settings_page.dart';
import 'package:jisho/widgets/search/search_bar.dart';

GlobalKey<SearchPageState> globalKey = GlobalKey();

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;

  final _pages = [
    SearchPage(key: globalKey),
    HistoryPage(),
    FavoritesPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: WordBloc(),
      child: MaterialApp(
        title: 'Jisho',
        locale: Locale("ja", "JP"),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Jisho'),
            backgroundColor: Colors.red[400],
            bottom: (_selectedIndex == 0)
                ? PreferredSize(
                    child: SearchBar((value) {
                      globalKey.currentState.updateSearch(value);
                    }),
                    preferredSize: Size.fromHeight(10.0 + 50.0 + 16.0),
                  )
                : null,
          ),
          body: Center(
            child: _pages.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.red[400],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
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
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
