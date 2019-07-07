import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Function update;
  SearchField(this.update);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
          hintText: "Search for Kanji, Words and Terms...",
          border: InputBorder.none,
          icon: Icon(
            Icons.search,
            color: Colors.black.withOpacity(0.5),
          )),
      onSubmitted: (value) => update(value),
    );
  }
}
