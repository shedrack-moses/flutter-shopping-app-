import 'package:eccomerce_app/component/cart_notifier.dart';

import 'package:eccomerce_app/pages/nav_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

final shoppingCart = ShoppingCart();

// class ProductsScreen extends StatelessWidget {
//   final ShoppingCart shoppingCart;

//   const ProductsScreen({super.key, required this.shoppingCart});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: Product.products.length,
//       itemBuilder: (context, index) {
//         final product = Product.products[index];
//         return ListTile(
//           leading: Image.network(product.imgUrl, width: 50, height: 50),
//           title: Text(product.title),
//           subtitle: Text('\$${product.price}'),
//           trailing: IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () => shoppingCart.addItemToCheckout(product),
//           ),
//         );
//       },
//     );
//   }
// }

class CheckoutScreen extends StatefulWidget {
  final ShoppingCart shoppingCart;

  const CheckoutScreen({super.key, required this.shoppingCart});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.shoppingCart.checkoutItems.length,
            itemBuilder: (context, index) {
              final item = widget.shoppingCart.checkoutItems[index];
              return Card(
                child: ListTile(
                  leading: Image.network(item.imgUrl, width: 50, height: 50),
                  title: Text(item.title),
                  subtitle: Text('\$${item.price}'),
                  trailing: Card(
                    child: IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          widget.shoppingCart.removeItemFromCheckout(item);
                          setState(() {});
                        }),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OrderSuccessScreen()),
              );
            },
            child: const Text('Place Order'),
          ),
        ),
      ],
    );
  }
}

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Successful'),
      ),
      body: const Center(
        child: Text(
          'Thank you for your order!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class ShoppingCartProvider extends StatefulWidget {
  final ShoppingCart shoppingCart;
  final Widget child;

  const ShoppingCartProvider(
      {super.key, required this.shoppingCart, required this.child});

  @override
  _ShoppingCartProviderState createState() => _ShoppingCartProviderState();

  static ShoppingCart of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<_InheritedShoppingCart>())!
        .shoppingCart;
  }
}

class _ShoppingCartProviderState extends State<ShoppingCartProvider> {
  @override
  void initState() {
    widget.shoppingCart.addListener(_onCartUpdated);
    super.initState();
  }

  @override
  void dispose() {
    widget.shoppingCart.removeListener(_onCartUpdated);
    super.dispose();
  }

  void _onCartUpdated() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedShoppingCart(
      shoppingCart: widget.shoppingCart,
      child: widget.child,
    );
  }
}

class _InheritedShoppingCart extends InheritedWidget {
  final ShoppingCart shoppingCart;

  const _InheritedShoppingCart(
      {required super.child, required this.shoppingCart});

  @override
  bool updateShouldNotify(_InheritedShoppingCart oldWidget) {
    return oldWidget.shoppingCart != shoppingCart;
  }
}
