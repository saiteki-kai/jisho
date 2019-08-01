import 'package:flutter/material.dart';
import 'package:jisho/widgets/search/search_field.dart';

class SearchBar extends StatelessWidget {
  final Function onSubmit, onClear;
  SearchBar(this.onSubmit, this.onClear);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5),
        ),
        child: SearchField(onSubmit, onClear),
      ),
    );
  }
}
