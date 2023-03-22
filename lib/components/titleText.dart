import 'package:flutter/material.dart';
import 'package:flutterstudy2/components/reviewStart.dart';

class TitleText extends StatelessWidget {
  final int? _star;
  final String txt;
  final CrossAxisAlignment? _alignment;


  const TitleText({Key? key, required this.txt})
      : this._star = null,
        _alignment = null,
        super(key: key);
  const TitleText.review({Key? key, required int star, required this.txt, required CrossAxisAlignment alignment})
      : _alignment = alignment,
        this._star = star,
        assert(alignment != null),
        super(key: key);


  @override
  Widget build(BuildContext context) {
    final TextStyle _titleTextStyle = TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
    );
    final Widget _txt = Text(this.txt, style: _titleTextStyle);
    if(this._star == null){
      return Container(
        child: _txt
      );
    };
    if(this._alignment == null) throw "Align";
    return Container(
      color: Colors.yellow,
      child: Column(
        crossAxisAlignment: this._alignment! ?? CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ReviewStar(value: this._star!),
          Container(color: Colors.red, child: _txt)
        ],
      ),
    );
  }
}
