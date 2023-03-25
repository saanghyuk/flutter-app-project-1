import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with AutomaticKeepAliveClientMixin{
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
                    decoration: InputDecoration(
                      filled : true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(),
                      hintText: "검색어를 입력해 주세요",
                      counterText: ""
                    ),
                    maxLength: 15,
                    style: TextStyle(fontSize: 15.0)
                    ,
                  ),
                  Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: IconButton(icon: Icon(Icons.close), onPressed: (){})
                  )

                ],
              )
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
