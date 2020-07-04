import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  ChartBar({
    this.label,
    this.value,
    this.percentage,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, contraint) {
        return (Column(
          children: <Widget>[
            Container(
              height: contraint.maxHeight * 0.15,
              child: FittedBox(
                child: Text('R\$${value.toStringAsFixed(2)}'),
              ),
            ),
            SizedBox(
              height: contraint.maxHeight * 0.05,
            ),
            Container(
              height: contraint.maxHeight * 0.6,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: contraint.maxHeight * 0.05,
            ),
            Container(
              height: contraint.maxHeight * 0.05,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        ));
      },
    );
  }
}
