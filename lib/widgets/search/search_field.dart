import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final Function onSubmit, onClear;

  SearchField(this.onSubmit, this.onClear);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      controller: _controller,
      style: TextStyle(fontSize: 19),
      decoration: InputDecoration(
        hintText: "Search for Kanji, Words, Names and Sentences...",
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(top: 12.8),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black.withOpacity(0.5),
        ),
        suffixIcon: GestureDetector(
          child: Icon(
            Icons.clear,
            color: Colors.black.withOpacity(0.5),
          ),
          onTap: () {
            _controller.clear();
            FocusScope.of(context).unfocus();
            widget.onClear();
          },
        ),
      ),
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        widget.onSubmit(_controller.text);
      },
    );
  }
}
