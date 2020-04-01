import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/Product.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  Future findProductFromBarcode(String barcode) async {
    // TODO: implement API call

    notifyListeners();
  }
}
