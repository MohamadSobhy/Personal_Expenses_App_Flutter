import 'dart:async';

import './../mixins/data_validator.dart';
import 'package:rxdart/subjects.dart';

class TransactionBloc extends Object with DataValidator {
  final _titleStreamController = BehaviorSubject<String>();
  final _amountStreamController = BehaviorSubject<String>();

  //getters
  Function(String) get addTitle => _titleStreamController.sink.add;
  Function(String) get addAmount => _amountStreamController.sink.add;

  Stream<String> get titleStream =>
      _titleStreamController.stream.transform(titleTransformer);
  Stream<String> get amountStream =>
      _amountStreamController.stream.transform(amountTransformer);

  dispose() {
    _titleStreamController.sink.close();
    _amountStreamController.sink.close();
  }
}
