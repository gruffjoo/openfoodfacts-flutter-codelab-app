import 'package:codelab_app/widgets/nutriscore_widget.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/Product.dart';

class ProductOverviewTile extends StatelessWidget {
  final Product product;

  ProductOverviewTile(this.product);

  Widget _buildProductImage() {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.fill, image: NetworkImage(product.imgSmallUrl))),
    );
  }

  Widget _buildTextsColumn() {
    return Column(
      children: <Widget>[Text(product.productName), Text(product.brands)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildProductImage(),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: _buildTextsColumn(),
        ),
        SizedBox(
          width: 8,
        ),
        NutriscoreWidget(product.nutriscore)
      ],
    );
  }
}
