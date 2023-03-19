import 'package:flutter/material.dart';

class TextBanner extends StatelessWidget {
  final Widget _child;

  const TextBanner({Key? key, required Widget child})
      : _child = child,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: this._child,
    );
  }
}
