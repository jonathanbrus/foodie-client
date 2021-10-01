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
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.38),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
        gradient: RadialGradient(
          colors: [
            Colors.white,
            Theme.of(context).primaryColor.withOpacity(0.4)
          ],
          radius: 1.6,
          focalRadius: 0.6,
          center: Alignment.bottomRight,
        ),
      ),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(routeName, arguments: [title, category]),
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 0.036,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(right: 6, bottom: 8),
              child: Container(
                width: width * 0.16,
                height: width * 0.16,
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
      ),
    );
  }
}
