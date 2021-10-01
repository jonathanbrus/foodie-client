import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

import '../../models/food.dart';

import '../../ui_widgets/price_tag.dart';

class FoodItem extends StatelessWidget {
  final Food food;

  const FoodItem({
    required this.food,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int time = DateTime.now().hour;

    bool availability = food.availableFrom <= time && food.availableTo >= time;

    final width = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        child: Row(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ColorFiltered(
                      colorFilter: availability
                          ? ColorFilter.mode(
                              Colors.transparent,
                              BlendMode.multiply,
                            )
                          : ColorFilter.mode(
                              Colors.grey,
                              BlendMode.saturation,
                            ),
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            width: width * 0.28,
                            height: width * 0.28,
                            imageUrl: food.image,
                            fit: BoxFit.cover,
                            placeholder: (ctx, url) => Image.asset(
                              "assets/fallback.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (food.bestSeller == true)
                            Positioned(
                              bottom: -1,
                              left: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 1.6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(0),
                                  ),
                                ),
                                child: Text(
                                  "Best Selling",
                                  style: TextStyle(
                                    fontSize: width * 0.02,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange.shade900,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                height: 132,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 6, right: 6),
                      child: Text(
                        food.name,
                        style: TextStyle(
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Consumer<FoodieCart>(builder: (ctx, foodieCart, ch) {
                      return Expanded(
                        child: (food.addons == null &&
                                    food.toppings == null &&
                                    food.sizes == null &&
                                    food.buns == null ||
                                !foodieCart.inCart(food.id))
                            ? Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  food.description,
                                  style: TextStyle(fontSize: width * 0.034),
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (food.addons != null)
                                    DropDown(
                                      id: food.id,
                                      title: "Addons",
                                      options: food.addons,
                                      selectOption: (id, optName, price) =>
                                          foodieCart.selectAddon(
                                        id,
                                        optName,
                                        price,
                                      ),
                                      getSelected: (id) => foodieCart.addon(
                                        id,
                                      ),
                                    ),
                                  if (food.toppings != null)
                                    DropDown(
                                      id: food.id,
                                      title: "Toppings",
                                      options: food.toppings,
                                      selectOption: (id, optName, price) =>
                                          foodieCart.selectTopping(
                                        id,
                                        optName,
                                        price,
                                      ),
                                      getSelected: (id) => foodieCart.topping(
                                        id,
                                      ),
                                    ),
                                  if (food.sizes != null)
                                    DropDown(
                                      id: food.id,
                                      title: "Sizes",
                                      options: food.sizes,
                                      selectOption: (id, optName, price) =>
                                          foodieCart.selectSize(
                                        id,
                                        optName,
                                        price,
                                      ),
                                      getSelected: (id) => foodieCart.size(
                                        id,
                                      ),
                                    ),
                                  if (food.buns != null)
                                    DropDown(
                                      id: food.id,
                                      title: "Buns",
                                      options: food.buns,
                                      selectOption: (id, optName, price) =>
                                          foodieCart.selectBun(
                                        id,
                                        optName,
                                        price,
                                      ),
                                      getSelected: (id) => foodieCart.bun(
                                        id,
                                      ),
                                    ),
                                ],
                              ),
                      );
                    }),
                    Row(
                      children: [
                        PriceTag(
                          fixedPrice: food.fixedPrice,
                          offerPrice: food.offerPrice,
                          fixedPriceSize: width * 0.034,
                          offerPriceSize: width * 0.038,
                          offerPercentSize: width * 0.032,
                        ),
                        Spacer(),
                        Container(
                          width: width * 0.24,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(16)),
                          ),
                          child: Consumer<FoodieCart>(builder: (ctx, cart, ch) {
                            int quantity = cart.quantity(food.id);
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                QtyButton(
                                  availability: availability,
                                  icon: Icons.remove_rounded,
                                  onPressed: () => cart.removeItem(food.id),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 250),
                                  width: quantity > 0 ? width * 0.056 : 0,
                                  height: width * 0.09,
                                  alignment: Alignment.center,
                                  color: quantity > 0
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                  child: Text(
                                    "${quantity > 0 ? quantity : ""}",
                                    style: TextStyle(fontSize: width * 0.034),
                                  ),
                                ),
                                QtyButton(
                                  availability: availability,
                                  icon: Icons.add_rounded,
                                  onPressed: () => cart.addItem(
                                    food.id,
                                    food.name,
                                    food.image,
                                    food.fixedPrice,
                                    food.offerPrice,
                                    food.packagingCharge,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropDown extends StatelessWidget {
  const DropDown({
    Key? key,
    required this.id,
    required this.title,
    required this.options,
    required this.selectOption,
    required this.getSelected,
  }) : super(key: key);

  final String id;
  final String title;
  final List? options;
  final Function selectOption;
  final Function getSelected;

  @override
  Widget build(BuildContext context) {
    Map? value = getSelected(id);

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        menuMaxHeight: 90,
        style: TextStyle(fontSize: 14),
        hint: Text(
          value == null ? title : "${value['name']} \u{20B9}${value['price']}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        onChanged: (dynamic val) {
          if (val != null) {
            selectOption(
              id,
              val["name"],
              val["price"],
            );
          }
        },
        items: [
          ...options!.map(
            (option) => DropdownMenuItem(
              child: Text(
                "${option['name']} \u{20B9}${option['price']}",
                style: TextStyle(color: Colors.black),
              ),
              value: option,
            ),
          ),
        ],
      ),
    );
  }
}

class QtyButton extends StatelessWidget {
  final bool availability;
  final Function onPressed;
  final IconData icon;
  const QtyButton({
    required this.availability,
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return IconButton(
      iconSize: width * 0.046,
      splashRadius: width * 0.056,
      constraints: BoxConstraints(
        minHeight: width * 0.036,
        minWidth: width * 0.036,
      ),
      onPressed: availability
          ? () => onPressed()
          : () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  duration: Duration(milliseconds: 1000),
                  content: Text("Current this food is not available."),
                  action: SnackBarAction(
                    textColor: Colors.white,
                    label: "Okay",
                    onPressed: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  ),
                ),
              );
            },
      icon: Icon(icon),
    );
  }
}
