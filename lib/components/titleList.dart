import 'package:flutter/material.dart';

class TitleListData{
  final String title;

  const TitleListData({required this.title});

  factory TitleListData.children({
                  required String title,
                  required List<Widget> children}){
    return TitleListDataChildren._(title: title, children: children);
  }

  factory TitleListData.builder({
          required String title,
          required int count,
          required Widget Function(BuildContext, int) builder
  }){
    return TitleListDataBuilder._(
              title : title,
              count: count,
              builder: builder
    );
  }
}

class TitleListDataChildren extends TitleListData{
  final List<Widget> children;
  // 기본 생성자 지워버리기
  const TitleListDataChildren._({required super.title, required this.children});
}

class TitleListDataBuilder extends TitleListData{
  final int count;
  final Widget Function(BuildContext, int) builder;
  TitleListDataBuilder._({required super.title, required this.count, required this.builder});
}


class TitleList extends StatelessWidget {
  final bool _check;
  // final TitleListDataChildren? _titleListDataChildren;
  // final TitleListDataBuilder? _titleListDataBuilder;
  final TitleListData titleListData;
  // final String title;
  // final List<Widget>? _children;
  // final int? _itemCount;
  // final Widget Function(BuildContext, int)? _itemBuilder;

  const TitleList({Key? key,
    // required this.title,
    // required List<Widget> children
    required this.titleListData
  })
      : this._check = false,
        // _titleListDataChildren = titleListData,
        // _titleListDataBuilder = null,
        // this._children = children,
        // this._itemBuilder = null,
        // this._itemCount = null,
        super(key: key);

  const TitleList.builder({
    Key? key,
    required this.titleListData
    // required this.title,
    // required int itemCount,
    // required Widget Function(BuildContext, int) itemBuilder
  })
      : _check = true,
        // _titleListDataBuilder = titleListData,
        // _titleListDataChildren = null,
        // this._itemCount = itemCount,
        // this._itemBuilder = itemBuilder,
        // this._children = null,
        super(key:key);

  @override
  Widget build(BuildContext context) {
    final TextStyle _titleTextStyle =TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0);
    // Widget _titleText = Text(
    //   this.titleListData.title,
    // );
    // 기본생성자
    if(!this._check){
      // 타입이 바뀌어줘야 한다.
      final TitleListDataChildren _data = titleListData as TitleListDataChildren;
      return Container(
        child: Column(

          children: [
            Container(
                color: Colors.yellow,
                alignment: Alignment.center,
                child: Text(_data.title, style: _titleTextStyle),
                margin: EdgeInsets.only(left:10.0, top:10.0, bottom:10.0, right: 30.0)
            ),
            Expanded(child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _data.children,
                )
            ))
          ],
        ),
      );
    }
    final TitleListDataBuilder _data = titleListData as TitleListDataBuilder;
    return Container(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(20.0),
                child: Text(_data.title, style: _titleTextStyle)
            ),
            Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _data.count,
                  itemBuilder: _data.builder,
                )
            )
          ],
        )
    );
  }
}



// Item에서도 최대한 사이즈 정하지 않는게 좋다. 사용 됬을 때 사이즈 정하도록
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
                // color: Colors.yellow,
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
                    Text(this.subTitle),
                  ],
                )
            )
          ],
        )
    );
  }
}