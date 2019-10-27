import 'dart:async';

class DataValidator {
  final StreamTransformer titleTransformer =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (String title, EventSink<String> sink) {
      if (title.trim().isEmpty) {
        sink.addError('Title Not specified!');
      } else {
        sink.add(title);
      }
    },
  );

  final StreamTransformer amountTransformer =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (String amount, EventSink<String> sink) {
      if (amount.isEmpty || double.parse(amount) <= 0.0) {
        sink.addError('Amount Not specified! it should be greater than zero.');
      } else {
        sink.add(amount.toString());
      }
    },
  );
}
