import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../providers/cart.dart';

class CartListItem extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final int fixedPrice;
  final int offerPrice;
  final int qunatity;

  const CartListItem(
      {required this.id,
      required this.name,
      required this.image,
      required this.fixedPrice,
      required this.offerPrice,
      required this.qunatity,
      Key? key})
      : super(key: key);

  @override
  _CartListItemState createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<Auth>(context).authToken;
    return Container(
      margin: EdgeInsets.only(top: 5),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(fontSize: 18),
                    ),
                    Divider(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\u20B9${widget.offerPrice}",
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "\u20B9${widget.fixedPrice}",
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 6),
                    Text(
                      "You saved \u20B9${widget.fixedPrice - widget.offerPrice}!",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text("Quantity :"),
                          SizedBox(width: 5),
                          Consumer<Cart>(
                            builder: (ctx, cartProvider, ch) => DropdownButton(
                              isDense: true,
                              underline: Container(
                                height: 2,
                                color: Theme.of(context).primaryColor,
                              ),
                              value: widget.qunatity,
                              onChanged: (int? val) {
                                cartProvider.modifyQuantity(
                                    widget.id, val!, token);
                              },
                              items: [1, 2, 3, 4, 5]
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text("$e"),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey, height: 0),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border_rounded,
                      size: 20,
                    ),
                    label: Text(
                      "Add to Wishlist",
                      style: TextStyle(fontSize: 14),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
                VerticalDivider(color: Colors.grey, width: 2),
                Expanded(
                  child: Consumer<Cart>(
                    builder: (ctx, cartProvider, ch) => TextButton.icon(
                      onPressed: () =>
                          cartProvider.removeFromCart(widget.id, token),
                      icon: Icon(
                        Icons.delete_rounded,
                        size: 20,
                      ),
                      label: Text(
                        "Remove",
                        style: TextStyle(fontSize: 14),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
