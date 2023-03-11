import 'package:flutter/material.dart';

class TitleList extends StatelessWidget {
  final bool _check;
  final String title;
  final List<Widget>? _children;
  final int? _itemCount;
  final Widget Function(BuildContext, int)? _itemBuilder;

  const TitleList({Key? key, required this.title, required List<Widget> children})
      : this._check = false,
        this._children = children,
        this._itemBuilder = null,
        this._itemCount = null,
        super(key: key);

  const TitleList.builder({Key? key, required this.title, required int itemCount, required Widget Function(BuildContext, int) itemBuilder})
      : _check = true,
        this._itemCount = itemCount,
        this._itemBuilder = itemBuilder,
        this._children = null,
        super(key:key);


  @override
  Widget build(BuildContext context) {
    Widget _titleText = Text(
        "AB180", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0));

    if(!this._check){
      return Container(
        child: Column(
          children: [
            Container(
              color: Colors.yellow,
              alignment: Alignment.center,
              child: _titleText,
              margin: EdgeInsets.only(left:30.0, top: 10.0, bottom:10.0, right: 30.0),
            ),
            Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: this._children!,
                  )
                )
            )
          ],
        ),
      );
    }
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20.0),
            child: _titleText
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount : this._itemCount,
                  itemBuilder: this._itemBuilder!,
              )
          )
        ],
      )
    );
  }
}
class TitleListItem extends StatelessWidget {
  final String img;
  final String title;
  final String subTitle;

  const TitleListItem({Key? key, required this.img, required this.title, required this.subTitle}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(this.img)
              )
            ),
          )),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(this.title),
                Text(this.subTitle)
              ],
            )
          )
        ],
      )
    );
  }
}

