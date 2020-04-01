import 'package:flutter/material.dart';

class NutriscoreWidget extends StatelessWidget {
  final String _productNutriscore;

  final List<String> _scores = ["A", "B", "C", "D", "E"];
  final Map<String, Color> _colors = {
    "A": Color.fromARGB(255, 68, 123, 71),
    "B": Color.fromARGB(255, 134, 174, 62),
    "C": Color.fromARGB(255, 233, 192, 51),
    "D": Color.fromARGB(255, 206, 110, 40),
    "E": Color.fromARGB(255, 190, 46, 32),
  };

  NutriscoreWidget(this._productNutriscore);

  //
  // ########### UI
  //

  Widget _buildTile(String value, bool isScoreOfProduct) {
    if (isScoreOfProduct)
      return Transform.scale(
        scale: 1.2,
        child: Container(
          decoration: BoxDecoration(
              color: _colors[value],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 2.0)),
        ),
      );

    return Container(
      color: _colors[value],
      child: Text(
        value,
        style: TextStyle(
            color: Colors.white.withAlpha(150),
            fontSize: 20,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 30,
      child: Column(
        children: _scores
            .map((score) => _buildTile(score, score == _productNutriscore))
            .toList(),
      ),
    );
  }
}
