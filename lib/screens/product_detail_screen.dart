import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/auth.dart';
import 'package:shopapp/providers/cart.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/ProductDetailScreen';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProd = Provider.of<Products>(context)
        .items
        .firstWhere((element) => element.id == productId);
    final cartData = Provider.of<Cart>(context);
    final authToken = Provider.of<Auth>(context).token;
    return Scaffold(
        appBar: AppBar(
          title: Text(loadedProd.title),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  loadedProd.imageUrl,
                  fit: BoxFit.cover,
                ),
                Text(
                  loadedProd.title,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                Text(
                  '\$${loadedProd.price}',
                  style: const TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Product Desctiption',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                Text(
                  loadedProd.description,
                  style: const TextStyle(fontSize: 15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: (() {
                        cartData.addItem(
                            loadedProd.id, loadedProd.price, loadedProd.title);
                      }),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(color: Colors.red)))),
                      child: const Text(
                        'Add to cart',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (() {
                        loadedProd.isFavorite;
                      }),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(color: Colors.red)))),
                      child: const Text(
                        'Add to favourites  ',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            cartData.addItem(loadedProd.id, loadedProd.price, loadedProd.title);
          }),
          child: const Icon(Icons.shopping_cart_checkout_rounded),
        ));
  }
}
