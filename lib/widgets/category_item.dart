import 'package:flutter/material.dart';
import 'package:jisho/models/category.dart';

class CategoryButton extends StatelessWidget {
  final Category category;
  final Function onSelect;

  CategoryButton({@required this.category, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        child: InkWell(
          onTap: onSelect,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: CategoryText(category: category),
            ),
          ),
        ),
        color: Colors.transparent,
      ),
      color: category.backgroundColor,
    );
  }
}

class CategoryText extends StatelessWidget {
  final Category category;

  CategoryText({@required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          category.title,
          style: TextStyle(
            fontFamily: 'OtsutomeFont',
            fontSize: 60,
            color: category.color,
          ),
        ),
        Text(
          category.subtitle.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'OtsutomeFont',
            fontSize: 24,
            color: category.color.withOpacity(0.85),
          ),
        )
      ],
    );
  }
}
