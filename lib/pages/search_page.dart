import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jisho/blocs/bloc.dart';
import 'package:jisho/pages/favorites_page.dart';
import 'package:jisho/pages/history_page.dart';
import 'package:jisho/pages/settings_page.dart';
import 'package:jisho/widgets/search_item.dart';
import 'package:jisho/widgets/search/search_bar.dart';
import 'package:jisho/widgets/word/word_list.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final _wordBloc = WordBloc();

  Map _selected;

  List options = [
    {
      "title": "言葉",
      "subtitle": "words",
      "backgroundColor": const Color(0xfff1b136),
    },
    {
      "title": "漢字",
      "subtitle": "kanji",
      "backgroundColor": const Color(0xffef6363),
    },
    {
      "title": "名前",
      "subtitle": "names",
      "backgroundColor": const Color(0xff13b0a5),
    },
    {
      "title": "文章",
      "subtitle": "sentences",
      "backgroundColor": const Color(0xff4fC3f7),
    }
  ];

  _message() {
    if (_selected != null) {
      return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SearchItem(
              title: _selected["title"],
              subtitle: _selected["subtitle"],
              backgroundColor: Colors.white,
              color: Colors.black,
            ),
          ],
        ),
      );
    }

    List<Widget> children = options.map(
      (o) {
        return SearchItem(
          title: o["title"],
          subtitle: o["subtitle"],
          backgroundColor: o["backgroundColor"],
          color: Colors.white,
          onSelect: () {
            setState(() {
              _selected = o;
            });
          },
        );
      },
    ).toList();

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          childAspectRatio: constraints.maxWidth / constraints.maxHeight,
          children: children,
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children.map((x) => Expanded(child: x)).toList(),
        );
      }
    });
  }

  updateSearch(value) {
    print("update: $value");
    if (_wordBloc.currentState is WordsLoading) {
      // cancel previous dispatch in same way...??
    }
    _wordBloc.dispatch(FetchWords(value));
  }

  clearSearch() {
    print("close");
    _wordBloc.dispatch(FetchWords(""));
  }

  Drawer buildDrawer() {
    return Drawer(
      child: ListView(
        // padding: EdgeInsets.zero,
        children: <Widget>[
          /*DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),*/
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorited'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => FavoritesPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => HistoryPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('JLPT'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.copyright),
            title: Text('Credits'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => SettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        drawer: buildDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: _selected == null ? Colors.black : Colors.white,
          ),
          title: Text(
            'Jisho',
            style: TextStyle(
              color: _selected == null ? Colors.black : Colors.white,
            ),
          ),
          backgroundColor:
              _selected == null ? Colors.white : _selected["backgroundColor"],
          bottom: PreferredSize(
            child: SearchBar(updateSearch, clearSearch),
            preferredSize: Size.fromHeight(10.0 + 50.0 + 16.0),
          ),
        ),
        body: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: BlocBuilder<WordBloc, WordState>(
                bloc: _wordBloc,
                builder: (BuildContext context, WordState state) {
                  print(state.runtimeType);
                  if (state is WordsLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _selected == null
                              ? Colors.amber
                              : _selected["backgroundColor"],
                        ),
                      ),
                    );
                  } else if (state is WordsLoaded) {
                    if (state.words.isEmpty) return Text("No Results");
                    return WordList(state.words);
                  } else {
                    return _message();
                  }
                },
              ),
            )
          ],
        ),
        resizeToAvoidBottomInset: _selected != null,
      ),
      onWillPop: _onWillPop,
    );
  }

  Future<bool> _onWillPop() async {
    if (_selected == null && _wordBloc.currentState is WordsEmpty) {
      Navigator.of(context).pop();
      return true;
    } else {
      setState(() {
        _selected = null;
      });
      clearSearch();
      return false;
    }
  }
}
