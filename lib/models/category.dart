import 'package:flutter/material.dart';

class Category {
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final Color color;

  Category(
      {this.title,
      this.subtitle,
      this.backgroundColor = Colors.white,
      this.color = Colors.black});
}
