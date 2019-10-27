import 'package:flutter/material.dart';
import 'package:personal_expenses_app/src/blocs/transaction_bloc.dart';

class TransactionProvider extends InheritedWidget {
  TransactionProvider({Key key, this.child}) : super(key: key, child: child);

  final Widget child;
  final bloc = TransactionBloc();

  static TransactionBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(TransactionProvider)
            as TransactionProvider)
        .bloc;
  }

  @override
  bool updateShouldNotify(TransactionProvider oldWidget) {
    return true;
  }
}
