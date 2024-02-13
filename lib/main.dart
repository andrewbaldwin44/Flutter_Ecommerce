import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shopper/utils/supabase.dart';
import 'package:shopper/screens/home_page.dart';
import 'package:shopper/screens/catalog.dart';
import 'package:shopper/screens/product_details.dart';
import 'package:shopper/models/cart.dart';

Future<void> main() async {
  await initializeSupabase();

  ChangeNotifierProvider(
    create: (context) => CartModel(),
    child: const App(),
  );
}

GoRouter router() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/catalog',
        builder: (context, state) => const CatalogPage(),
      ),
      GoRoute(
          path: '/product/:id',
          builder: (context, state) =>
              ProductDetails(id: state.pathParameters['id']!)),
    ],
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shopping App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      routerConfig: router(),
    );
  }
}
