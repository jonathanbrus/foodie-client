import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

// providers
import '../providers/products.dart';
import '../models/product.dart';

// widgets
import '../../ui_widgets/product_item.dart';
import '../../ui_widgets/loader.dart';

class ProductsScreen extends StatefulWidget {
  static const routeName = "/products";

  final String title;
  final String category;

  const ProductsScreen({
    required this.title,
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _loader = true;
  late Function clearSelection;

  @override
  void deactivate() {
    clearSelection =
        Provider.of<Products>(context, listen: false).clearSelection;
    super.deactivate();
  }

  @override
  void dispose() {
    clearSelection();
    super.dispose();
  }

  Future<void> fetch(productsProvider) async {
    await productsProvider.fetchProducts(widget.category);
    if (mounted) {
      setState(() {
        _loader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);

    fetch(productsProvider);

    List<Product> allProducts =
        productsProvider.getAllProductsByCategory(widget.category);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(widget.title),
        backgroundColor: Theme.of(context).primaryColor,
        bottom: PreferredSize(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, bottom: 15, right: 15),
                child: Consumer<Products>(
                  builder: (BuildContext ctx, foods, ch) => TextField(
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
                      fillColor: Colors.black.withOpacity(0.16),
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
              Categories(category: widget.category),
            ],
          ),
          preferredSize: Size(double.infinity, 126),
        ),
      ),
      body: SafeArea(
        child: _loader
            ? Loader()
            : allProducts.isNotEmpty
                ? GridView.builder(
                    padding: EdgeInsets.all(5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (ctx, index) {
                      return ProductGridItem(
                        productDetail: allProducts[index],
                      );
                    },
                    itemCount: allProducts.length,
                  )
                : Center(
                    child: SizedBox(
                      width: 180,
                      height: 180,
                      child: Lottie.asset(
                        "assets/lottie/emptyRes.json",
                        repeat: true,
                      ),
                    ),
                  ),
      ),
    );
  }
}

class Categories extends StatefulWidget {
  final String category;
  const Categories({required this.category, Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);

    List categories = productsProvider.categories(widget.category);

    List selections = productsProvider.selections;

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
            pressElevation: 4,
            selected: selections.contains(categories[i]),
            selectedColor: Theme.of(context).primaryColor.withOpacity(0.16),
            labelStyle: TextStyle(
              color: selections.contains(categories[i])
                  ? Theme.of(context).primaryColor
                  : Colors.black.withOpacity(0.4),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Colors.black.withOpacity(0.02),
            checkmarkColor: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            label: Text(categories[i]),
            onSelected: (bool val) => productsProvider.select(
              val,
              categories[i],
            ),
          ),
        ),
      ),
    );
  }
}
