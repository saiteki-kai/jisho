import 'package:flutter/material.dart';

abstract class SearchResults extends StatefulWidget {
  final Widget message;
  final Key key;

  SearchResults({@required this.message, this.key});
}

abstract class SearchResultsState extends State<SearchResults> {
  void onSearch(String value);
  void onClear();
}
