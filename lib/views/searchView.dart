import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with AutomaticKeepAliveClientMixin{
  final TextEditingController _controller = TextEditingController()

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _viewSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        width: _viewSize.width,
        child: Column(
          children: [
            Platform.isIOS ?
            CupertinoTextField(
              clearButtonMode: OverlayVisibilityMode.editing,
            )
                :
            Container(
              margin: EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  TextField(
                    controller: this._controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(), // OutlineInputBorder
                      hintText: "검색어를 입력해 주세요",
                      counterText: ""
                    ),
                    maxLength: 10,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom:0,
                    child: IconButton(icon: Icon(Icons.close), onPressed: (){},)
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
