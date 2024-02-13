import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopper/utils/supabase.dart';
import 'package:shopper/utils/image.dart';

class ProductDetails extends StatefulWidget {
  final String id;

  const ProductDetails({super.key, required this.id});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
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
          onPressed: () => GoRouter.of(context).go('/catalog'),
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
                ],
              ),
            )
          : const CircularProgressIndicator(),
    );
  }
}
