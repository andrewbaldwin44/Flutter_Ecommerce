import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopper/utils/supabase.dart';
import 'package:shopper/utils/image.dart';
import 'package:shopper/models/cart.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final String id;

  const ProductDetails({super.key, required this.id});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _AddButton extends StatelessWidget {
  final Map<String, dynamic>? product;

  const _AddButton({required this.product});

  @override
  Widget build(BuildContext context) {
    // The context.select() method will let you listen to changes to
    // a *part* of a model. You define a function that "selects" (i.e. returns)
    // the part you're interested in, and the provider package will not rebuild
    // this widget unless that particular part of the model changes.
    //
    // This can lead to significant performance improvements.
    var isInCart = context.select<CartModel, bool>(
      // Here, we are only interested whether [item] is inside the cart.
      (cart) => cart.items.contains(product),
    );

    return TextButton(
      onPressed: isInCart
          ? null
          : () {
              // If the item is not in cart, we let the user add it.
              // We are using context.read() here because the callback
              // is executed whenever the user taps the button. In other
              // words, it is executed outside the build method.
              var cart = context.read<CartModel>();
              cart.add(product);
              context.go('/cart');
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isInCart
          ? const Icon(Icons.check, semanticLabel: 'ADDED')
          : const Text('ADD'),
    );
  }
}

class _ProductDetailsState extends State<ProductDetails> {
  Map<String, dynamic>? product;

  @override
  void initState() {
    super.initState();
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    final response =
        await supabase.from('products').select().eq('id', widget.id).single();

    setState(() {
      product = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product?['name'] ?? ''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/catalog'),
        ),
      ),
      body: product != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.memory(
                    base64DecodeImage(
                      product?['image_src'],
                    ),
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product?['name'] ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product?['price'] ?? '',
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),
                  _AddButton(product: product)
                ],
              ),
            )
          : const CircularProgressIndicator(),
    );
  }
}
