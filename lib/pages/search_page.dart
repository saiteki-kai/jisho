import 'package:flutter/material.dart';
import 'package:jisho/models/category.dart';

import 'package:jisho/pages/favorites_page.dart';
import 'package:jisho/pages/history_page.dart';
import 'package:jisho/pages/settings_page.dart';
import 'package:jisho/utils/fade.dart';
import 'package:jisho/widgets/search_appbar.dart';
import 'package:jisho/widgets/search_item.dart';
import 'package:jisho/widgets/results/search_results.dart';
import 'package:jisho/widgets/results/words_search_results.dart';
import 'package:jisho/widgets/results/kanji_search_results.dart';

class SearchPage extends StatefulWidget {
  final Category category;

  SearchPage({this.category});

  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  GlobalKey<SearchResultsState> key = GlobalKey();

  List _categories = [
    Category(
      title: "言葉",
      subtitle: "words",
      backgroundColor: const Color(0xfff1b136),
      color: Colors.white,
    ),
    Category(
      title: "漢字",
      subtitle: "kanji",
      backgroundColor: const Color(0xffef6363),
      color: Colors.white,
    ),
    Category(
      title: "名前",
      subtitle: "names",
      backgroundColor: const Color(0xff13b0a5),
      color: Colors.white,
    ),
    Category(
      title: "文章",
      subtitle: "sentences",
      backgroundColor: const Color(0xff4fC3f7),
      color: Colors.white,
    ),
  ];

  get category => widget.category;

  // TODO: implement mixed search with expandable sections
  _buildBody(Widget fallbackMessage) {
    switch (category?.subtitle) {
      case "words":
        return WordsSearchResults(key: key, message: fallbackMessage);
      case "kanji":
        return KanjiSearchResults(key: key, message: fallbackMessage);
      case "names":
        return WordsSearchResults(key: key, message: fallbackMessage);
      case "sentences":
        return WordsSearchResults(key: key, message: fallbackMessage);
      default:
        List<Widget> children = _categories.map(
          (cat) {
            return SearchItem(
              category: cat,
              onSelect: () {
                Navigator.of(context).push(
                  FadeRoute(page: SearchPage(category: cat)),
                );
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
  }

  updateSearch(value) {
    key.currentState.onSearch(value);
  }

  clearSearch() {
    key.currentState.onClear();
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
            leading: Icon(Icons.info),
            title: Text('About'),
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

  // TODO: Results Number in the AppBar
  // TODO: Make SearchItem Responsive

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    final fallbackMessage = Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SearchItem(
            category: Category(
              title: category?.title,
              subtitle: category?.subtitle,
              backgroundColor: Colors.white,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      drawer: buildDrawer(),
      appBar: SearchAppBar(category, updateSearch, clearSearch),
      body: _buildBody(fallbackMessage),
      resizeToAvoidBottomInset:
          orientation == Orientation.portrait && category != null,
    );
  }
}
