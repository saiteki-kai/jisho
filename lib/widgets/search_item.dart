import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final Color color;
  final Function onSelect;

  SearchItem(
      {@required this.title,
      @required this.subtitle,
      this.backgroundColor,
      this.color,
      this.onSelect});

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
                  title,
                  style: TextStyle(
                    fontFamily: 'OtsutomeFont',
                    fontSize: orientation == Orientation.portrait ? 60 : 40,
                    color: color,
                  ),
                ),
                SizedBox(height: orientation == Orientation.portrait ? 20 : 10),
                Text(
                  subtitle.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'OtsutomeFont',
                    fontSize: orientation == Orientation.portrait ? 24 : 12,
                    color: color.withOpacity(0.85),
                  ),
                )
              ],
            ),
          ),
        ),
        color: Colors.transparent,
      ),
      color: backgroundColor,
    );
  }
}
