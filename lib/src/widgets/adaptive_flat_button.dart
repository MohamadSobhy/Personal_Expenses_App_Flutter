import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function clickCallback;

  AdaptiveFlatButton(this.text, this.clickCallback);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: clickCallback,
            child: _buildButtonChild(),
          )
        : FlatButton(
            onPressed: clickCallback,
            textColor: Theme.of(context).primaryColor,
            child: _buildButtonChild(),
          );
  }

  Widget _buildButtonChild() {
    return Text(
      'Choose Date',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
