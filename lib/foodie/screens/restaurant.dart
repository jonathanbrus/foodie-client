import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/foods.dart';
import '../providers/cart.dart';

import './foodie_checkout.dart';

import '../widgets/custom_appBar.dart';
import '../../ui_widgets/food_item.dart';
import '../../ui_widgets/loader.dart';

class Restaurant extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final int distance;

  static const routeName = "single-restaurant";
  const Restaurant({
    required this.id,
    required this.name,
    required this.image,
    required this.distance,
    Key? key,
  }) : super(key: key);

  @override
  _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  late Function clearSelection;
  late Function clearCart;

  @override
  void deactivate() {
    clearSelection = Provider.of<Foods>(context, listen: false).clearSelection;
    clearCart = Provider.of<FoodieCart>(context, listen: false).clearCart;
    super.deactivate();
  }

  @override
  void dispose() {
    clearSelection();
    clearCart();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foodsProvider = Provider.of<Foods>(context);

    foodsProvider.fetchFoods(widget.id);

    final allFood = foodsProvider.getAllFoods(widget.id);

    final int deliveryCharge =
        widget.distance <= 5 ? 30 : 30 + (widget.distance - 5) * 5;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: widget.name,
            resId: widget.id,
          ),
          SliverList(
            delegate: allFood.isNotEmpty
                ? SliverChildBuilderDelegate(
                    (BuildContext ctx, int i) {
                      return Container(
                        child: Consumer<FoodieCart>(
                          builder: (ctx, cart, ch) => FoodItem(
                            id: allFood[i].id,
                            name: allFood[i].name,
                            image: allFood[i].image,
                            description: allFood[i].description,
                            quantity: cart.quantity(allFood[i].id),
                            fixedPrice: allFood[i].fixedPrice,
                            offerPrice: allFood[i].offerPrice,
                            packagingCharge: allFood[i].packagingCharge,
                          ),
                        ),
                      );
                    },
                    childCount: allFood.length,
                  )
                : SliverChildListDelegate(
                    [
                      Container(
                        height: MediaQuery.of(context).size.height - 206,
                        child: Loader(),
                      ),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: Consumer<FoodieCart>(
        builder: (ctx, cart, ch) => cart.cartItems.length > 0
            ? FloatingActionButton.extended(
                onPressed: () => Navigator.of(context).pushNamed(
                    FoodieCheckOut.routeName,
                    arguments: [widget.name, deliveryCharge]),
                icon: Icon(Icons.shopping_bag_rounded),
                label: Text(
                  "${cart.itemsCount}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            : Container(),
      ),
    );
  }
}
