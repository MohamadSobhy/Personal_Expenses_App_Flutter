import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../widgets/adaptive_flat_button.dart';
import './../blocs/transaction_bloc.dart';

class NewTransactionForm extends StatefulWidget {
  final TransactionBloc bloc;
  final Function(String, double, DateTime) _addTransaction;

  NewTransactionForm(this.bloc, this._addTransaction);

  @override
  _NewTransactionFormState createState() => _NewTransactionFormState();
}

class _NewTransactionFormState extends State<NewTransactionForm> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          StreamBuilder(
            stream: widget.bloc.titleStream,
            builder: (BuildContext context, AsyncSnapshot shanshot) {
              return TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'New Shoes',
                  errorText: shanshot.error,
                ),
                onChanged: widget.bloc.addTitle,
              );
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          StreamBuilder(
            stream: widget.bloc.amountStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Padding(
                padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom) *
                    0.5,
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    hintText: '99.99',
                    errorText: snapshot.error,
                  ),
                  onChanged: widget.bloc.addAmount,
                ),
              );
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  _selectedDate == null
                      ? 'Date is not chosen'
                      : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}',
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              AdaptiveFlatButton('Choose Date', _showTransactionDatePicker),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          FlatButton(
            onPressed: () {
              _addNewTransaction(widget.bloc);
            },
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).textTheme.button.color,
            child: Text(
              'Add Transaction'.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _showTransactionDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      setState(() {
        if (pickedDate != null) {
          _selectedDate = pickedDate;
        } else {
          _selectedDate = null;
        }
      });
    });
  }

  void _addNewTransaction(TransactionBloc bloc) {
    final newTitle = titleController.value.text;
    final newAmount = double.parse(amountController.value.text != ''
        ? amountController.value.text
        : '0.0');

    if (newTitle.isEmpty || newAmount <= 0 || _selectedDate == null) {
      bloc.addTitle(newTitle);
      bloc.addAmount(amountController.value.text);
      return;
    }

    widget._addTransaction(
      newTitle,
      newAmount,
      _selectedDate,
    );
  }
}
