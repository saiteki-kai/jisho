import 'package:flutter/material.dart';
import 'package:jisho/widgets/search_field.dart';

class SearchBar extends StatelessWidget {
  final Function update;
  SearchBar(this.update);

  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: BoxDecoration(color: Colors.red[400], boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SearchField(update),
            ),
          ),
        ));
  }
}