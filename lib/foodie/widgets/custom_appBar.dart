import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/foods.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final String resId;

  const CustomSliverAppBar({
    required this.title,
    required this.resId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: GestureDetector(
        onTap: () => Navigator.maybePop(context),
        child: Icon(Icons.arrow_back_ios_new_rounded),
      ),
      title: Text(title),
      pinned: true,
      bottom: PreferredSize(
        child: Column(
          children: [
            SearchAndFilter(),
            Categories(resId: resId),
          ],
        ),
        preferredSize: Size(double.infinity, 126),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  final String resId;
  const Categories({required this.resId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foods = Provider.of<Foods>(context);
    List categories = foods.categories(resId);

    return Container(
      height: 56,
      color: Colors.white,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext ctx, int i) => Padding(
          padding: EdgeInsets.only(
            left: 8,
            right: i + 1 == categories.length ? 8 : 0,
          ),
          child: FilterChip(
            selected: foods.selections.contains(categories[i]),
            selectedColor: Theme.of(context).primaryColor.withOpacity(0.16),
            labelStyle: TextStyle(
              color: foods.selections.contains(categories[i])
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).accentColor.withOpacity(0.4),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.02),
            checkmarkColor: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            label: Text(categories[i]),
            onSelected: (bool val) => foods.select(val, categories[i]),
          ),
        ),
      ),
    );
  }
}

class SearchAndFilter extends StatelessWidget {
  SearchAndFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 68,
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15, bottom: 15, right: 15),
              child: Consumer<Foods>(
                builder: (BuildContext ctx, foods, ch) => TextField(
                  // controller: _search,
                  onChanged: (String value) {
                    foods.setSearch(value);
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.white),
                    suffixIcon: Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).accentColor.withOpacity(0.16),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
