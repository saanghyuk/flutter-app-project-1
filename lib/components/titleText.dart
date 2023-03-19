
import 'package:flutter/material.dart';
import 'package:flutterstudy2/components/reviewStart.dart';

class TitleText extends StatelessWidget {
  final int? _star;
  final String txt;
  final CrossAxisAlignment? _alignment;


  const TitleText({Key? key, required this.txt}) :
        _alignment = null,
        this._star = null, super(key: key);
  const TitleText.review({Key? key, required int star, required this.txt, required CrossAxisAlignment alignment})
      : this._alignment = alignment,
        this._star = star,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle _titleTxtStyle = TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
    );
    final Widget _txt = Text(this.txt, style: _titleTxtStyle);
    if(this._star == null){
      return Container(
        child:_txt
      );
    }

    if(this._alignment == null) throw "align";
    return Container(
      child: Column(
        crossAxisAlignment: this._alignment!,
        mainAxisSize: MainAxisSize.min,
        children: [
          ReviewStar(value: this._star!),
          _txt
        ],
      )
    );
  }
}


