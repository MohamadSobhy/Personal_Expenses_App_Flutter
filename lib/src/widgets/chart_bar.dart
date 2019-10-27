import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final dayLabel;
  final daySpending;
  final daySpendingPtc;

  const ChartBar(this.dayLabel, this.daySpending, this.daySpendingPtc);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                daySpending.toStringAsFixed(0),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10.0,
            child: Stack(
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.6,
                  width: 10.0,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(220, 220, 220, 1),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: daySpendingPtc,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                dayLabel,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
