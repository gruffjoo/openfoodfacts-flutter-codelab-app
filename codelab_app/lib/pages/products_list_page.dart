import 'package:codelab_app/pages/product_detail_page.dart';
import 'package:codelab_app/pages/scanner_page.dart';
import 'package:codelab_app/providers/products_provider.dart';
import 'package:codelab_app/widgets/product_overview_tile.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/Product.dart';
import 'package:provider/provider.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  /// The offset applied on the Products list widget when presenting the scanner
  /// behind.
  Animation<Offset> _transitionProductsListOffset;

  double get _dragExtent => MediaQuery.of(context).size.height;
  bool _dragIsGoingUp = false;

  //
  // ########### LIFECYCLE
  //

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _transitionProductsListOffset =
        Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 0.85)).animate(
            CurvedAnimation(
                curve: Curves.easeInOut, parent: _animationController));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
  // ########### DRAG / SCANNER ANIMATION
  //

  void _handleDragIndicatorTap() {
    // Animation at the beginning = products list presented
    if (_animationController.value < 0.5)
      _animationController.forward();
    // Animation at the end = scanner presented
    else
      _animationController.reverse();
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    _dragIsGoingUp = details.primaryDelta < 0;

    double progress =
        _animationController.value + details.primaryDelta / (_dragExtent * 0.8);

    _animationController.value = progress;
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    if (_dragIsGoingUp) {
      // Animation from the scanner to close the scanner
      if (_animationController.value <= 0.75)
        _animationController.reverse();
      else
        _animationController.forward();
    } else {
      // Animation from the product list to open the scanner
      if (_animationController.value >= 0.25)
        _animationController.forward();
      else
        _animationController.reverse();
    }
  }

  //
  // ########### UI
  //

  Widget _buildDragIndicator() {
    return GestureDetector(
      onVerticalDragUpdate: _handleVerticalDragUpdate,
      onVerticalDragEnd: _handleVerticalDragEnd,
      onTap: _handleDragIndicatorTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        // GestureDetector
        margin: EdgeInsets.symmetric(horizontal: 60.0, vertical: 12.0),
        width: 60,
        height: 8,
        decoration: BoxDecoration(
            color: Colors.grey.withAlpha(150),
            borderRadius: BorderRadius.circular(5)),
      ),
    );
  }

  Widget _buildEmptyProductsPlaceholder() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          "Pas de produits pour le moment.\nRemplissez la liste en scannant des codes-barre de produits.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildProductsList(List<Product> products) {
    return ListView.separated(
      padding: EdgeInsets.all(0.0),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => _presentProductDetailPage(products[index]),
          child: Container(
              padding: EdgeInsets.all(12.0),
              child: ProductOverviewTile(products[index])),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          color: Colors.grey.withAlpha(40),
          height: 1,
        );
      },
    );
  }

  Widget _buildProductsListPage() {
    final ProductsProvider provider = Provider.of<ProductsProvider>(context);
    Widget pageContent;

    if (provider.products == null || provider.products.isEmpty)
      pageContent = _buildEmptyProductsPlaceholder();
    else
      pageContent = _buildProductsList(provider.products);

    return SlideTransition(
      position: _transitionProductsListOffset,
      child: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0))),
          child: Column(
            children: <Widget>[
              _buildDragIndicator(),
              Expanded(
                child: pageContent,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      // child is not used since transition widgets are nested deeper
      builder: (BuildContext context, _) {
        return Scaffold(
          body: Stack(
            children: <Widget>[ScannerPage(), _buildProductsListPage()],
          ),
        );
      },
    );
  }
}
