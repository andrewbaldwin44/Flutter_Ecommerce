import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopper/config/supabase.dart';
import 'package:shopper/utils/image.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await supabase.from('products').select().limit(10);

    setState(() {
      products = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Catalog'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => GoRouter.of(context).go('/'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return GestureDetector(
                onTap: () {
                  GoRouter.of(context).go('/product/${product["id"]}');
                },
                child: GridTile(
                  footer: GridTileBar(
                    backgroundColor: Colors.black45,
                    title: Text(product['name'] ?? '',
                        textAlign: TextAlign.center),
                    subtitle: Text(product['price'] ?? '',
                        textAlign: TextAlign.center),
                  ),
                  child: Image.memory(base64DecodeImage(product['image_src']),
                      fit: BoxFit.cover),
                ),
              );
            },
          ),
        ));
  }
}
