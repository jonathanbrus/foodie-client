import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String category;
  final String routeName;
  final String img;

  const CategoryItem({
    Key? key,
    required this.title,
    required this.category,
    required this.routeName,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(routeName, arguments: [title, category]),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  child: Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(img),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
