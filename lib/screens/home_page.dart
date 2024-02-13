import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopper/widgets/cart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home Page"),
      ),
      endDrawer: const Cart(),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/catalog'),
          child: const Text('Go to the catalog'),
        ),
      ),
    );
  }
}
