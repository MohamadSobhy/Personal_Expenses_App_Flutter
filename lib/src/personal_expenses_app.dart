import 'package:flutter/material.dart';
import 'package:personal_expenses_app/src/blocs/transaction_bloc_provider.dart';

import './screens/home_screen.dart';

class PersonalExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses App',
      home: TransactionProvider(
        child: HomeScreen(),
      ),
      theme: ThemeData(
        fontFamily: 'Quicksand',
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.black,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
          ),
          subtitle: TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.grey,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.normal,
          ),
          button: TextStyle(
            color: Colors.white,
          ),
        ),
        primarySwatch: Colors.purple,
        accentColor: Colors.purple,
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
                color: Colors.white,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
