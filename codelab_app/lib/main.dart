import 'package:codelab_app/pages/products_list_page.dart';
import 'package:codelab_app/providers/personal_settings_provider.dart';
import 'package:codelab_app/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductsProvider>(
            create: (_) => ProductsProvider()),
        ChangeNotifierProvider<PersonalSettingsProvider>(create: (_) {
          var provider = PersonalSettingsProvider();
          provider.initializeValues();
          return provider;
        }),
      ],
      child: MaterialApp(
        title: 'Flutter OpenFoodFacts Codelab',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: ProductsListPage(),
      ),
    );
  }
}
