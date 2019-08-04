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

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: color),
      title: Text('Jisho', style: TextStyle(color: color)),
      backgroundColor: bgColor,
      bottom: PreferredSize(
        child: SearchBar(widget.onSearch, widget.onClear),
        preferredSize: Size.fromHeight(68.0),
      ),
    );
  }
}
