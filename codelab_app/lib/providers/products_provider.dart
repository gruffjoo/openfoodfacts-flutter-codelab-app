import 'package:codelab_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  Future findProductFromBarcode(String barcode) async {
    // TODO: implement API call

    notifyListeners();
  }
}
