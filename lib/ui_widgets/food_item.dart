import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../foodie/providers/cart.dart';

class FoodItem extends StatelessWidget {
  final String id;
  final String name;
  final String image;
  final String description;
  final int fixedPrice;
  final int offerPrice;
  final int packagingCharge;
  final int quantity;
  // final Function addToCart;
  // final Function removeFromCart;

  const FoodItem({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.fixedPrice,
    required this.offerPrice,
    required this.packagingCharge,
    required this.quantity,
    // required this.addToCart,
    // required this.removeFromCart,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final int offer = (((fixedPrice - offerPrice) / fixedPrice) * 100).ceil();
    return Card(
      margin: EdgeInsets.all(8),
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
                    child: CachedNetworkImage(
                      width: 120,
                      height: 120,
                      imageUrl: image,
                      fit: BoxFit.cover,
                      placeholder: (ctx, url) => Image.asset(
                        "assets/fallback.jpg",
                        fit: BoxFit.cover,
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
                        name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(right: 6),
                    //   child: Text(
                    //     description,
                    //     maxLines: name.length > 25 ? 2 : 3,
                    //   ),
                    // ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              style: TextStyle(fontSize: 14),
                              items: [
                                DropdownMenuItem(child: Text("Addons")),
                              ],
                            ),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              style: TextStyle(fontSize: 14),
                              items: [
                                DropdownMenuItem(child: Text("Toppings")),
                              ],
                            ),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              style: TextStyle(fontSize: 14),
                              items: [
                                DropdownMenuItem(child: Text("Size")),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Rs.$offerPrice",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Rs.$fixedPrice",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(16)),
                          ),
                          child: Consumer<FoodieCart>(
                            builder: (ctx, cart, ch) => Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                QtyButton(
                                  icon: Icons.remove_rounded,
                                  onPressed: () => cart.removeItem(id),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 250),
                                  width: quantity > 0 ? 28 : 0,
                                  height: 36,
                                  alignment: Alignment.center,
                                  color: quantity > 0
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                  child: Text(
                                    "${quantity > 0 ? quantity : ""}",
                                  ),
                                ),
                                QtyButton(
                                  icon: Icons.add_rounded,
                                  onPressed: () => cart.addItem(
                                    id,
                                    name,
                                    image,
                                    fixedPrice,
                                    offerPrice,
                                    packagingCharge,
                                  ),
                                ),
                              ],
                            ),
                          ),
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

class QtyButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  const QtyButton({
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 20,
      splashRadius: 26,
      constraints: BoxConstraints(
        minHeight: 24,
        minWidth: 24,
      ),
      onPressed: () => onPressed(),
      icon: Icon(icon),
    );
  }
}
