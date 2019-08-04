import 'package:flutter/material.dart';
import 'package:jisho/widgets/search/search_field.dart';

class SearchBar extends StatelessWidget {
  final Function onSubmit, onClear;
  SearchBar(this.onSubmit, this.onClear);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => print("SearchBar size: ${context.size}"));

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
        top: 4.0,
      ),
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
