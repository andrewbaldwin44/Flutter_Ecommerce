import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go('/catalog'),
              child: const Text('Go to the catalog'),
            ),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go('/cart'),
              child: const Text('Go to the cart'),
            ),
          ],
        ),
      ),
    );
  }
}
