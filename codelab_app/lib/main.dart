import 'package:codelab_app/pages/products_list_page.dart';
import 'package:codelab_app/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsProvider(),
      child: MaterialApp(
        title: 'Flutter OpenFoodFacts Codelabe',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: ProductsListPage(),
      );,
    )
  }
}
