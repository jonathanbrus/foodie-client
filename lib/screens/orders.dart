import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//provider
import '../../providers/orders.dart';
// import '../../providers/auth.dart';

//widgets
import '../widgets/double_back.dart';
import '../widgets/bottom_navigation.dart';
import '../ui_widgets/order_item.dart';

enum Choice { All, Foods, Others }

class OrdersScreen extends StatefulWidget {
  static const routeName = "/orders";
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Choice _selected = Choice.All;

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    // final token = Provider.of<Auth>(context, listen: false).authToken;

    // orders.fetchAllOrders(token);

    List filteredOrders = orders.allOrders;

    if (_selected == Choice.Foods) {
      filteredOrders =
          orders.allOrders.where((order) => order.isFood == true).toList();
    } else if (_selected == Choice.Others) {
      filteredOrders =
          orders.allOrders.where((order) => order.isFood == false).toList();
    } else {
      filteredOrders = orders.allOrders;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("My Orders"),
        actions: [
          PopupMenuButton(
            onSelected: (Choice val) {
              setState(() {
                _selected = val;
              });
            },
            icon: Icon(Icons.filter_list_rounded),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text("All Orders"),
                value: Choice.All,
              ),
              PopupMenuItem(
                child: Text("Food Orders"),
                value: Choice.Foods,
              ),
              PopupMenuItem(
                child: Text("Other Orders"),
                value: Choice.Others,
              ),
            ],
          )
        ],
      ),
      body: DoubleBack(
        child: SafeArea(
          child: ListView(
            children: [
              if (filteredOrders.isEmpty)
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 200,
                        child: Image.asset("assets/order.png"),
                      ),
                      Text(
                        "No Orders Yet !",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ...filteredOrders.map((order) => OrderListItem(order: order)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigator(index: 3),
    );
  }
}
