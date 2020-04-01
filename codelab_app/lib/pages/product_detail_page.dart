import 'package:codelab_app/widgets/product_overview_tile.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/Product.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  ProductDetailPage(this.product);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // TODO: to implement

  Widget _buildHeader() {
    return Material(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.only(
            bottom: 12,
            left: 12,
            right: 12,
            top: MediaQuery.of(context).padding.top + 12),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: Navigator.of(context).pop,
            ),
            Expanded(
              child: ProductOverviewTile(widget.product),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildHeader(),
        ],
      ),
    );
  }
}
