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
    this._controller.dispose();
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
            InputField(
                // onChanged: (String input){},
                controller: this._controller),
            Wrap(
              spacing: 10.0,
              alignment: WrapAlignment.start,
              children: ["추천검색1", "검색2", "추천검색2", "추천검색2", "검색2", "추천검색3", "검색4"].map<Widget>(
                  (String txt) => Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: InkWell(
                        // radius: 100.0,
                        borderRadius: BorderRadius.circular(20.0),
                        onTap:(){},
                        child: Container(
                          child: InkWell(
                              child: Text(txt)),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          padding : EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                          // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        ),
                      )
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
      onChanged: this.onChanged,
      controller: this.controller,
      clearButtonMode: OverlayVisibilityMode.editing,
    )
        :
    Container(
        margin: EdgeInsets.all(20.0),
        child: Stack(
          children: [
            TextField(
              onChanged: this.onChanged,
              controller : this.controller,
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
                child: IconButton(icon: Icon(Icons.close), onPressed: this.controller.clear
                )
            )
          ],
        )
    );
  }
}
