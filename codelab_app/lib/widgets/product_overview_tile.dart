import 'package:codelab_app/widgets/nutriscore_widget.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/Product.dart';

class ProductOverviewTile extends StatelessWidget {
  final Product product;

  ProductOverviewTile(this.product);

  Widget _buildProductImage() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.fill, image: NetworkImage(product.imgSmallUrl))),
    );
  }

  Widget _buildTextsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (product.productName != null && product.productName.isNotEmpty)
          Text(
            product.productName,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        if (product.brands != null && product.brands.isNotEmpty)
          Text(product.brands)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (product.imgSmallUrl != null) _buildProductImage(),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: _buildTextsColumn(),
        ),
        SizedBox(
          width: 8,
        ),
        if (product.nutriscore != null) NutriscoreWidget(product.nutriscore)
      ],
    );
  }
}
