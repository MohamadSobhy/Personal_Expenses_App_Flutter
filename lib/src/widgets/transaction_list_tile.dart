import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../models/transaction.dart';

class TransactionListTile extends StatelessWidget {
  final Transaction _transactionData;
  final Function(int) deleteTransactionCallback;
  final int index;

  TransactionListTile(
      this._transactionData, this.deleteTransactionCallback, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Card(
        elevation: 5.0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.purple,
            radius: 30.0,
            child: FittedBox(
              child: Text(
                _transactionData.amount.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          title: Text(
            _transactionData.title,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(_transactionData.date),
            style: Theme.of(context).textTheme.subtitle,
          ),
          trailing: MediaQuery.of(context).size.width > 460
              ? FlatButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text('Delete'),
                  textColor: Theme.of(context).errorColor,
                  onPressed: () {
                    deleteTransactionCallback(index);
                  },
                )
              : IconButton(
                  onPressed: () {
                    deleteTransactionCallback(index);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
        ),
      ),
    );
  }
}
