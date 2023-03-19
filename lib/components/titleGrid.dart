import 'package:flutter/material.dart';


class TitleGrid extends StatelessWidget {
  final bool _isBuilder;
  final SliverGridDelegate? _sliver;
  final Widget Function(BuildContext, int)? _itemBuilder;
  final int? _itemCount;

  // List<Widget>
  final List<List<Widget>>? _children;
  final int? _rowCount;
  final String title;
  final Axis? _axis;


  const TitleGrid({Key? key,
    required List<List<Widget>> children,
    required int rowCount, required this.title
  })
      : _isBuilder = false,
        _sliver= null,
        _itemBuilder = null,
        _itemCount = null,
        _children = children,
        _rowCount = rowCount,
        _axis = null,
        super(key: key);
  const TitleGrid.builder({
    Key? key, required SliverGridDelegate sliverGridDelegate,
    required Widget Function(BuildContext, int) itemBuilder, required int itemCount, required this.title,
    Axis axis = Axis.vertical,
  })
      : _isBuilder = true,
        _children = null,
        _sliver = sliverGridDelegate,
        _itemBuilder = itemBuilder,
        _itemCount = itemCount,
        _rowCount =null,
        _axis = axis,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if(!this._isBuilder) return Container(
        child: Column(
          // children: [
          //   Row(
          //     children: [
          //       Container(),
          //       Container()
          //     ],
          //   ),
          // ],
          children: [
            Text(this.title),
            ...this._children!.map<Widget>(
                    (List<Widget> child) {
                  if(child.length != this._rowCount!){
                    // @TODO : 나중에 처리 필요.
                    // child의 Length가 > row count
                    // child의 Length가 < row count
                  }
                  return Row(
                      children: child.map<Widget>(
                              (Widget w) => w
                      ).toList()
                  );
                }
            ).toList()
          ],
        )
    );
    return Column(
      children: [
        Text(this.title),
        Expanded(
          child: GridView.builder(
            scrollDirection: _axis!,
            itemCount: this._itemCount,
            gridDelegate: this._sliver!,
            itemBuilder: this._itemBuilder!,
          ),
        ),
      ],
    );
  }
}