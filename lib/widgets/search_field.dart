import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final String hint;
  final Function setSearch;

  SearchField({
    Key? key,
    required this.hint,
    required this.setSearch,
  }) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.only(
        top: 0,
        left: 15,
        bottom: 14,
        right: 15,
      ),
      alignment: Alignment.center,
      child: TextField(
        // controller: _search,
        onChanged: (String value) {
          widget.setSearch(value);
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.white),
          suffixIcon: Icon(
            Icons.search_rounded,
            color: Colors.white,
            size: 28,
          ),
          filled: true,
          fillColor: Colors.black.withOpacity(0.16),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
