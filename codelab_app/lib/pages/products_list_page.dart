import 'package:codelab_app/models/product.dart';
import 'package:codelab_app/pages/product_detail_page.dart';
import 'package:codelab_app/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  //
  // ########### NAVIGATION
  //

  void _presentScannerPage() {
    // TODO: to implement
  }

  void _presentProductDetailPage(Product product) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ProductDetailPage(product)));
  }

  //
  // ########### UI
  //

  Widget _buildEmptyProductsPlaceholder() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
            "Pas de produits pour le moment.\nRemplissez la liste en scannant des codes-barre de produits."),
      ),
    );
  }

  Widget _buildProductsList(List<Product> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        // TODO: to implement
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ProductsProvider provider = Provider.of<ProductsProvider>(context);
    Widget child;

    if (provider.products == null || provider.products.isEmpty)
      child = _buildEmptyProductsPlaceholder();
    else
      child = _buildProductsList(provider.products);

    return Scaffold(
      body: child,
    );
  }
}
