import 'package:flutter/material.dart';
import 'package:jisho/models/category.dart';
import 'package:jisho/widgets/search/search_bar.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Category category;
  final Function onSearch;
  final Function onClear;

  SearchAppBar(this.category, this.onSearch, this.onClear);

  @override
  SearchAppBarState createState() => SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(56.0 + 68.0);
}

class SearchAppBarState extends State<SearchAppBar> {
  get category => widget.category;
  get color => category == null ? Colors.black : Colors.white;
  get bgColor => category == null ? Colors.white : category.backgroundColor;
  get fieldColor => category == null ? Colors.grey[200] : Colors.white;
  get title => capitalize(category?.subtitle) ?? "Jisho";

  String capitalize(String text) {
    if (text == null || text.isEmpty) return null;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // TODO: implement this
          return AppBar(
            iconTheme: IconThemeData(color: color),
            title: Text(title, style: TextStyle(color: color)),
            backgroundColor: bgColor,
            actions: <Widget>[
              IconButton(
                tooltip: "Search",
                icon: Icon(Icons.search),
                onPressed: () => null,
              )
            ],
          );
        }

        return AppBar(
          iconTheme: IconThemeData(color: color),
          title: Text(title, style: TextStyle(color: color)),
          backgroundColor: bgColor,
          bottom: PreferredSize(
            child: SearchBar(widget.onSearch, widget.onClear, fieldColor),
            preferredSize: Size.fromHeight(68.0),
          ),
        );
      },
    );
  }
}
