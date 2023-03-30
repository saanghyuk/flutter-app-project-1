import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with AutomaticKeepAliveClientMixin{
  final TextEditingController _controller = TextEditingController();

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
              InputField(controller: this._controller),
              Wrap(
                spacing: 3.0,
                alignment: WrapAlignment.start,
                children: ["추천검색1", "검색1","추천검색2", "검색2","추천검색3", "검색3", "추천검색4", "추천검색5", "추천검색6"]
                    .map<Widget>((String txt) => Container(
                        margin: EdgeInsets.symmetric(horizontal:10.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade200,
                          border: Border.all(), 
                          borderRadius: BorderRadius.circular(20.0)
                                ),
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20.0),
                          onTap: (){},
                          child: Container(
                            // color: Colors.yellow.shade200,
                            // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                              child: Text(txt)
                          ),
                        ),
                      )

                ).toList(),
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

class InputField extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController controller;
  const InputField({Key? key, this.onChanged, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ?
    CupertinoTextField(
      clearButtonMode: OverlayVisibilityMode.editing,
    )
        :
    Container(
      margin: EdgeInsets.all(20.0),
      child: Stack(
        children: [
          TextField(
            onChanged: this.onChanged,
            controller: this.controller,
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
    );
  }
}
