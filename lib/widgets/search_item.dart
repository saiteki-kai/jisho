import 'package:flutter/material.dart';
import 'package:jisho/models/category.dart';

class SearchItem extends StatelessWidget {
  final Category category;
  final Function onSelect;

  SearchItem({@required this.category, this.onSelect});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Container(
      child: Material(
        child: InkWell(
          onTap: onSelect,
          child: Container(
            padding: const EdgeInsets.only(bottom: 8, top: 30),
            child: Column(
              children: <Widget>[
                Text(
                  category.title,
                  style: TextStyle(
                    fontFamily: 'OtsutomeFont',
                    fontSize: orientation == Orientation.portrait ? 60 : 40,
                    color: category.color,
                  ),
                ),
                SizedBox(height: orientation == Orientation.portrait ? 20 : 10),
                Text(
                  category.subtitle.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'OtsutomeFont',
                    fontSize: orientation == Orientation.portrait ? 24 : 12,
                    color: category.color.withOpacity(0.85),
                  ),
                )
              ],
            ),
          ),
        ),
        color: Colors.transparent,
      ),
      color: category.backgroundColor,
    );
  }
}
