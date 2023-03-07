import 'package:flutter/material.dart'; 

class TitleList extends StatelessWidget {
  final bool _check;
  final String title;
  final List<Widget>? _children;
  final int? _itemCount;
  final Widget Function(BuildContext, int)? _itemBuilder;

  const TitleList({Key? key,
                    required this.title,
                     // this로 바로 받으면 쓰는 쪽에서 nullable로 보이니깐 이렇게 한 것
                    required List<Widget> children,
                }) : _check = false,
                    _children = children,
                    _itemCount = null, _itemBuilder = null,
                    super(key: key);
  const TitleList.builder({Key? key,
                    required this.title,
                    required int itemCount,
                    required Widget Function(BuildContext, int) itemBuilder,
                  }) : _check = true,
                      _children = null,
                      _itemCount = itemCount,
                      _itemBuilder = itemBuilder,
                      super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _titleText = Text(this.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0));
    // 기본 생성자
    if(!this._check){
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Container(
                child: _titleText,
                margin: EdgeInsets.only(left:30.0, top:10.0, bottom: 10.0),
              ),
              Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: this._children!,
                    ),
                  )
              )
        ],
        ),
      );
    }
    return Container(
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.all(10.0),
              child: _titleText
          ),
          Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: this._itemCount,
                itemBuilder: this._itemBuilder!,
              )
          )
        ],
      ),
    );
  }
}
