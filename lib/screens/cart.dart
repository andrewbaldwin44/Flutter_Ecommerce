import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper/models/cart.dart';
import 'package:shopper/utils/image.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return ListView.builder(
            itemCount: cart.products.length,
            itemBuilder: (context, index) {
              final product = cart.products[index];
              return ListTile(
                title: Text(product?['name']),
                subtitle: Text('\$${product?['price']}'),
                leading: Image.memory(
                  base64DecodeImage(
                    product?['image_src'],
                  ),
                  height: 200,
                  width: 200,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
