import 'package:codelab_app/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: "QR");
  QRViewController _qrViewController;

  //
  // ########### LIFECYCLE
  //

  @override
  void dispose() {
    _qrViewController.dispose();
    super.dispose();
  }

  //
  // ########### SCANNER
  //

  void _onQRViewCreated(QRViewController controller) {
    _qrViewController = controller;
    _qrViewController.scannedDataStream.listen(_onCodeScanned);
  }

  Future _onCodeScanned(String code) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .findProductFromBarcode(code);
  }

  //
  // ########### UI
  //

  Widget _buildViewFinderOverlay() {
    return Center(
      child: Padding(
        // Using screen size to show how to create padding proportional to the size
        // of the screen.
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 3.0)),
          ),
        ),
      ),
    );
  }

  Widget _buildContinuousScannerWidget() {
    return QRView(
      key: _qrKey,
      onQRViewCreated: _onQRViewCreated,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildContinuousScannerWidget(),
          _buildViewFinderOverlay()
        ],
      ),
    );
  }
}
