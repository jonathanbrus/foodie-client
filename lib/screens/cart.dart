import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/user.dart';

import '../helpers/checkout_helper.dart';

//widgets
import '../ui_widgets/cart_item.dart';
import '../ui_widgets/loader.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/cart";
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _loading = true;

  void fetch(context, cartProvider) async {
    final token = Provider.of<User>(context).authToken;

    await cartProvider.myCart(token);

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);
    fetch(context, cartProvider);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("My Cart"),
      ),
      body: SafeArea(
        child: _loading
            ? Loader()
            : ListView(
                children: [
                  ...cartProvider.getAllProducts.map((cartItem) => CartListItem(
                        id: cartItem.id,
                        name: cartItem.name,
                        image: cartItem.image,
                        fixedPrice: cartItem.fixedPrice,
                        offerPrice: cartItem.offerPrice,
                        qunatity: cartItem.quantity,
                      )),
                  if (cartProvider.getAllProducts.isEmpty)
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.46,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 160,
                            height: 200,
                            child: Image.asset(
                              "assets/cart.png",
                            ),
                          ),
                          Text(
                            "Your Cart Is Empty !",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  FreeDeliveryCard(
                      text: "Free delivery for orders above Rs.499"),
                  CashLessPayNotice(),
                ],
              ),
      ),
      bottomNavigationBar: BottomContainer(
        cartItems: [...cartProvider.getAllProducts],
        buyFrom: "AloFoodie",
        isFood: false,
        cartItemsAmount: cartProvider.totalItemsAmount,
        taxAmount: cartProvider.taxAmount,
        packagingCharge: 0,
        deliveryCharge: cartProvider.deliveryCharge,
        freeDeliveryMargin: 999,
        clearCart: cartProvider.clearCart,
      ),
    );
  }
}
