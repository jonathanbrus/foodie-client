import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../providers/foods.dart';
import '../providers/cart.dart';

import 'cart.dart';

import '../widgets/custom_appBar.dart';
import '../widgets/food_item.dart';
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
  @override
  void didChangeDependencies() {
    final int deliveryCharge =
        widget.distance <= 2 ? 20 : 20 + (widget.distance - 2) * 5;

    Provider.of<FoodieCart>(context, listen: false)
        .setRestaurantAndDeliveryCharge(
      restaurantName: widget.name,
      deliveryCharge: deliveryCharge,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final foodsProvider = Provider.of<Foods>(context);

    final allFood = foodsProvider.getAllFoods(widget.id);

    return WillPopScope(
      onWillPop: () => showdialogue(context),
      child: Scaffold(
        body: FutureBuilder(
            future: foodsProvider.fetchFoods(widget.id),
            builder: (context, snapshot) {
              return CustomScrollView(
                slivers: [
                  CustomSliverAppBar(
                    title: widget.name,
                    resId: widget.id,
                    loaded: snapshot.connectionState == ConnectionState.done,
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([SizedBox(height: 8)])),
                  SliverList(
                    delegate: snapshot.connectionState == ConnectionState.done
                        ? allFood.isNotEmpty
                            ? SliverChildBuilderDelegate(
                                (BuildContext ctx, int i) {
                                  return Container(
                                    child: FoodItem(
                                      food: allFood[i],
                                    ),
                                  );
                                },
                                childCount: allFood.length,
                              )
                            : SliverChildListDelegate(
                                [
                                  Container(
                                    height: MediaQuery.of(context).size.height -
                                        216,
                                    child: Center(
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
                                ],
                              )
                        : SliverChildListDelegate(
                            [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height - 206,
                                child: Loader(),
                              ),
                            ],
                          ),
                  ),
                ],
              );
            }),
        floatingActionButton: Consumer<FoodieCart>(
          builder: (ctx, cart, ch) => cart.cartItems.length > 0
              ? FloatingActionButton.extended(
                  onPressed: () => Navigator.of(context).pushNamed(
                      FoodieCheckOut.routeName,
                      arguments: [widget.name]),
                  icon: Icon(Icons.shopping_bag_rounded),
                  label: Text(
                    "${cart.itemsCount}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}

Future<bool> showdialogue(context) async {
  final value = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content:
              Text("Your cart will be cleared, Are you sure you want to exit?"),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              child: Text('Yes, exit'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      });

  if (value == true) {
    final foods = Provider.of<Foods>(context, listen: false);
    Provider.of<FoodieCart>(context, listen: false).clearCart();
    foods.clearSelection();
    foods.setSearch("");
    foods.toggleVeg(false);
  }

  return value == true;
}
