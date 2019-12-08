import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './../blocs/transaction_bloc_provider.dart';
import './../widgets/new_transaction_form.dart';
import './../models/transaction.dart';
import './../widgets/transaction_list_tile.dart';
import './../widgets/chart.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _transactionList = [
    Transaction(
      id: DateTime.now().toString(),
      title: 'New Shoes',
      amount: 19.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'New T-Shirt',
      amount: 121.99,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'New Shoes',
      amount: 19.99,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'New T-Shirt',
      amount: 121.99,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'New Shoes',
      amount: 19.99,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'New T-Shirt',
      amount: 121.99,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'New Shoes',
      amount: 19.99,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'New T-Shirt',
      amount: 121.99,
      date: DateTime.now().subtract(Duration(days: 7)),
    ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentUserTransaction {
    if (_transactionList.isEmpty) return [];
    return _transactionList.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = _buildAppBar(context);
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: _buildPageBody(isLandscape, context, mediaQuery, appBar),
          )
        : Scaffold(
            appBar: appBar,
            body: _buildPageBody(isLandscape, context, mediaQuery, appBar),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _showAddTransactionSheet(context);
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
  }

  Widget _buildPageBody(bool isLandscape, BuildContext context,
      MediaQueryData mediaQuery, AppBar appBar) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape) ..._buildLandscapeContent(mediaQuery, appBar),
            if (!isLandscape) ..._buildPortraitContent(mediaQuery, appBar),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery, AppBar appBar) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentUserTransaction),
      ),
      _buildTransactionList(appBar, mediaQuery)
    ];
  }

  List<Widget> _buildLandscapeContent(mediaQuery, appBar) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.title,
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (switchVal) {
              setState(() {
                _showChart = switchVal;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentUserTransaction),
            )
          : _buildTransactionList(appBar, mediaQuery),
    ];
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses App',
              style: Theme.of(context).appBarTheme.textTheme.title,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    CupertinoIcons.add,
                  ),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Personal Expenses App',
              style: Theme.of(context).appBarTheme.textTheme.title,
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  _showAddTransactionSheet(context);
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          );
  }

  Widget _buildTransactionList(appBar, mediaQuery) {
    return Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: _transactionList.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'No Transactions created yet.',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemCount: _transactionList.length,
              itemBuilder: (BuildContext context, int index) {
                return TransactionListTile(
                  _transactionList[index],
                  _deleteTransactionCallback,
                  index,
                );
              },
            ),
    );
  }

  void _deleteTransactionCallback(int index) {
    setState(() {
      _transactionList.removeAt(index);
    });
  }

  void _showAddTransactionSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15.0),
          ),
        ),
        builder: (_) {
          return _buildBottomSheetBody(context);
        });
  }

  Widget _buildBottomSheetBody(BuildContext context) {
    final bloc = TransactionProvider.of(context);

    return NewTransactionForm(bloc, _addNewTransaction);
  }

  void _addNewTransaction(
      String newTitle, double newAmount, DateTime _selectedDate) {
    setState(() {
      _transactionList.add(
        Transaction(
          id: DateTime.now().toString(),
          title: newTitle,
          amount: newAmount,
          date: _selectedDate,
        ),
      );
    });

    Navigator.of(context).pop();
  }
}
