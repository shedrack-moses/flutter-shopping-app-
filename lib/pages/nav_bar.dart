import 'package:eccomerce_app/component/cart_notifier.dart';
import 'package:eccomerce_app/main.dart';
import 'package:eccomerce_app/pages/home.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final ShoppingCart _shoppingCart = ShoppingCart();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions() => <Widget>[
        ProductScreen(shoppingCart: _shoppingCart),
        CheckoutScreen(shoppingCart: _shoppingCart),
      ];

  @override
  Widget build(BuildContext context) {
    return ShoppingCartProvider(
      shoppingCart: _shoppingCart,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shopping App'),
        ),
        body: _widgetOptions()[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Checkout',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blueAccent[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
