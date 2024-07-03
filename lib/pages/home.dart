import 'package:eccomerce_app/component/cart_notifier.dart';
import 'package:eccomerce_app/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  final ShoppingCart shoppingCart;
  const ProductScreen({super.key, required this.shoppingCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo[50],
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: Product.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.8),
            itemBuilder: (context, index) {
              final product = Product.products[index];
              return Card(
                  child: Column(children: <Widget>[
                Image.network(
                  Product.products[index].imgUrl,
                  height: 120,
                  width: 120,
                ),
                Text(
                  Product.products[index].title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("\$${Product.products[index].price}"),
                OutlinedButton(
                    child: const Text("Add"),
                    onPressed: () {
                      shoppingCart.addItemToCheckout(product);
                    })
              ]));
            }));
  }
}
