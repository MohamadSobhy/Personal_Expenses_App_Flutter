import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransaction;

  Chart(this._recentTransaction);

  List<Map<String, Object>> get _groupedTransactionList {
    return List<Map<String, Object>>.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double spendingOfDay = 0.0;

      for (int i = 0; i < _recentTransaction.length; i++) {
        if (weekDay.day == _recentTransaction[i].date.day &&
            weekDay.month == _recentTransaction[i].date.month &&
            weekDay.year == _recentTransaction[i].date.year) {
          spendingOfDay += _recentTransaction[i].amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "spending": spendingOfDay
      };
    }).reversed.toList();
  }

  double get _totalSpending {
    return _recentTransaction.fold(0.0, (sum, transaction) {
      return sum + transaction.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Card(
        elevation: 6.0,
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _groupedTransactionList.map((dayData) {
              return Expanded(
                child: ChartBar(
                    dayData['day'],
                    dayData['spending'],
                    _totalSpending == 0.0
                        ? 0.0
                        : (dayData['spending'] as double) / _totalSpending),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
