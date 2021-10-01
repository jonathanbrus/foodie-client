import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

import '../../models/cart_item.dart';

import '../../ui_widgets/price_tag.dart';

class FoodCartItem extends StatelessWidget {
  final CartItem cartItem;

  const FoodCartItem({
    required this.cartItem,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    child: CachedNetworkImage(
                      width: 100,
                      height: 100,
                      imageUrl: cartItem.image,
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
                height: 112,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 6, right: 6),
                      child: Text(
                        cartItem.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (cartItem.addon != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Addon"),
                                Text(
                                    "${cartItem.addon} \u{20B9}${cartItem.addonPrice}"),
                              ],
                            ),
                          if (cartItem.topping != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Topping"),
                                Text(
                                    "${cartItem.topping} \u{20B9}${cartItem.toppingPrice}"),
                              ],
                            ),
                          if (cartItem.size != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Size"),
                                Text(
                                    "${cartItem.size} \u{20B9}${cartItem.sizePrice}"),
                              ],
                            ),
                          if (cartItem.bun != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Bun"),
                                Text(
                                    "${cartItem.bun} \u{20B9}${cartItem.bunPrice}"),
                              ],
                            ),
                          SizedBox(width: 6),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        PriceTag(
                          fixedPrice: cartItem.fixedPrice,
                          offerPrice: cartItem.offerPrice,
                          fixedPriceSize: 14,
                          offerPriceSize: 16,
                          offerPercentSize: 12,
                        ),
                        Spacer(),
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(16)),
                          ),
                          child: Consumer<FoodieCart>(builder: (ctx, cart, ch) {
                            int quantity = cart.quantity(cartItem.id);

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                QtyButton(
                                  icon: Icons.remove_rounded,
                                  onPressed: () => cart.removeItem(cartItem.id),
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
                                    cartItem.id,
                                    cartItem.name,
                                    cartItem.image,
                                    cartItem.fixedPrice,
                                    cartItem.offerPrice,
                                    cartItem.packagingCharge,
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
